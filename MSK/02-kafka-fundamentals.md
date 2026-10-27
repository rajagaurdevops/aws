# 2. Kafka fundamentals and glossary

| Term | Meaning | Example |
|------|---------|---------|
| Event / record / message | A unit of data written to Kafka. | `order_id=101, status=created` |
| Producer | Application/client that writes records. | The checkout service publishes an order. |
| Consumer | Application/client that reads records. | Fulfillment service reads orders. |
| Topic | Named stream/category of records. | `orders`, `payments`, `telemetry` |
| Partition | Ordered log segment of a topic; enables parallelism. | `orders-0`, `orders-1`, `orders-2` |
| Broker | Kafka server that stores partition replicas and serves clients. | Broker 1 in a three-broker cluster |
| Partition leader | Replica that handles normal reads/writes for a partition. | Leader for `orders` partition 0 |
| Follower replica | Copy that fetches data from the leader. | Replica for `orders` partition 0 on another broker |
| Replication factor (RF) | Number of copies of each partition. | RF=3 means three replicas per partition |
| Offset | Position of a record within one partition. | Offset 42 in partition 1 |
| Consumer group | Consumers sharing work and tracking group offsets. | `order-processing` |
| Consumer lag | How far a consumer group is behind the end of a partition. | Group is 500 records behind |
| Bootstrap brokers | Initial broker endpoints used for cluster discovery. | MSK IAM bootstrap string |
| Retention | How long/large Kafka keeps records before cleanup. | Keep events for 7 days |
| Key | Record field used for partition selection and grouping. | `customer-101` |
| Schema | Contract defining record structure and types. | Avro/JSON Schema/Protobuf |
| ISR | In-sync replicas: replicas sufficiently caught up with the leader. | Leader plus healthy followers |
| Rebalance | Reassignment of partitions among consumers in a group. | Consumer joins or leaves |
| Dead-letter topic (DLT/DLQ) | Topic used to isolate records that repeatedly fail processing. | `orders-dead-letter` |
| Backpressure | Slowing or limiting upstream flow when downstream cannot keep up. | Pause consumption while DB is overloaded |

## A simple business example

- **Decoupled Communication:** when a customer places an order, the checkout service doesn't need to call the payment, shipping, and analytics systems directly. Instead, it simply drops a single `OrderCreated` event onto the `orders` topic (like posting a notice on a bulletin board). This means if the shipping service goes offline temporarily, the checkout service isn't affected and doesn't crash.
- **Independent Processing:** the payment service, shipping service, and analytics tool each belong to separate consumer groups. They pull the order event independently and perform their respective tasks (processing payment, preparing delivery, recording metrics) at their own speed.
