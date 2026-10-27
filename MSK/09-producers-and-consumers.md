# 9. Producers and consumers: code patterns

The examples below show the application concepts. Authentication libraries and exact client configuration differ by language and cluster authentication method. Use the official AWS client setup guide for the exact supported configuration for your language.

## Producer responsibilities

- Build the event and validate required fields.
- Choose a stable key when ordering by entity matters (for example `customer_id` or `order_id`).
- Serialize the key and value to bytes, JSON, Avro, or another agreed format.
- Send to the correct topic and handle asynchronous success/failure callbacks.
- Use appropriate retries, timeouts, idempotence, batching, compression, and acknowledgments.
- Record delivery errors and metrics without logging sensitive payloads.

## Python producer example (conceptual, PLAINTEXT for local Kafka only)

> This example is deliberately a local-development pattern. **Do not use PLAINTEXT for production MSK.** Configure TLS/IAM/SCRAM/mTLS using the matching client instructions for your cluster.

```python
import json
from kafka import KafkaProducer

producer = KafkaProducer(
    bootstrap_servers=["localhost:9092"],
    key_serializer=lambda k: k.encode("utf-8") if k else None,
    value_serializer=lambda v: json.dumps(v).encode("utf-8"),
    acks="all",
)

event = {
    "event_type": "OrderCreated",
    "order_id": 101,
    "amount": 55000,
}

try:
    result = producer.send(
        "orders",
        key="order-101",
        value=event,
    ).get(timeout=10)
    print("topic:", result.topic)
    print("partition:", result.partition)
    print("offset:", result.offset)
finally:
    producer.close()
```

## Consumer responsibilities

- Subscribe to the required topic with a stable consumer group ID.
- Handle partition assignment and rebalances correctly.
- Process records safely and track progress through offsets.
- Choose auto-commit or manual commit based on the processing guarantee you need.
- Make side effects idempotent when duplicate processing is possible.
- Monitor lag and processing errors; use a dead-letter strategy for poison messages.

## Python consumer example (conceptual, PLAINTEXT for local Kafka only)

```python
import json
from kafka import KafkaConsumer

consumer = KafkaConsumer(
    "orders",
    bootstrap_servers=["localhost:9092"],
    group_id="order-processing",
    auto_offset_reset="earliest",
    enable_auto_commit=False,
    value_deserializer=lambda b: json.loads(b.decode("utf-8")),
)

try:
    for record in consumer:
        event = record.value
        print(record.topic, record.partition, record.offset, event)
        # Process the event successfully here.
        # Commit only after processing succeeds, if this is your chosen model.
        consumer.commit()
finally:
    consumer.close()
```

> **Important:** committing after processing can still result in duplicates if the process crashes after the side effect but before the commit. Make processing idempotent or use a stronger coordinated design where needed.

## How producer partition selection works

- With a key, the default partitioner typically maps the same key to the same partition while the partition count and partitioner remain compatible.
- Without a key, distribution follows the client's partitioner and batching behavior; it is not a per-partition quota.
- An explicit partition parameter can target a partition, but application code must then handle skew and partition changes carefully.

## Consumer group example

For a topic with 3 partitions and a consumer group with 3 consumers, Kafka can assign one partition to each consumer. With 1 consumer, it can own all 3 partitions. With 5 consumers, at most 3 can own partitions for that topic in that group; the rest are idle for that topic. Another consumer group can read the same topic independently.
