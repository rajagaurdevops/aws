# 4. Topics, Partitions, Offsets, and Consumer Groups

## Topic

A Kafka topic is a named stream where related events are stored and organized. Producers send events to topics, and consumers read those events.

For example, an online shopping application might use these topics:

- `orders` — stores events about customer orders.
- `payments` — stores events about payment transactions.
- `user-signups` — stores events when new users register.

**Example:** when a customer places an order, the checkout service publishes an `OrderCreated` event to the `orders` topic.

## Partitions

A partition is a portion of a topic's data. Kafka divides topics into partitions to distribute data across brokers and allow multiple consumers to process events in parallel.

For example, if the `orders` topic has three partitions — Partition 0, Partition 1, and Partition 2 — Kafka can distribute order events among them.

Kafka keeps messages in order within the same partition, but not across different partitions. Messages with the same key usually go to the same partition, so their order is preserved as long as the partition mapping stays consistent.

## Kafka offset

A Kafka offset is a number that identifies a record's position within a partition. It helps a consumer track which records it has read and where it should continue reading.

Think of an offset like a bookmark in a book. If you stop reading at page 5, your bookmark helps you continue from where you left off.

## Consumer Groups

A consumer group is a group of consumers that work together to read a topic. Kafka assigns each partition to at most one consumer within a group at a time.

For example, suppose the `orders` topic has three partitions:

- With one consumer, that consumer can read all three partitions.
- With three consumers in one group, each consumer can read one partition.
- With five consumers in one group, at most three consumers can actively read these partitions at a time; the remaining two will be idle for this topic.

Different consumer groups can read the same topic independently. For example, a `payment-group` processes payments, while an `analytics-group` analyzes sales. Each group tracks its own reading progress using offsets, so one group's progress does not prevent another group from reading the same events.

**Best practices:** use clear and consistent topic names, choose partition counts based on throughput and parallelism requirements, and create separate consumer groups for applications that need to process the same events independently.

### Consumer Groups and Parallelism

A consumer reads messages from Kafka. A consumer group is a collection of consumers working together to read messages from a topic in parallel.

Imagine a Kafka topic called `orders` with 3 partitions:

| Partitions | Consumers | What happens? |
|-----------|-----------|---------------|
| 3 | 1 | One consumer reads all 3 partitions. |
| 3 | 2 | One consumer reads 2 partitions; the other reads 1. |
| 3 | 3 | Each consumer reads exactly 1 partition. |
| 3 | 5 | Only 3 consumers actively read partitions; 2 remain idle for this topic. |

**Remember:**

- One partition can be assigned to only one consumer in the same group at a time.
- Adding more consumers helps process messages in parallel, but the number of partitions sets the upper limit on parallelism within a group.
- A completely separate consumer group can independently read the exact same topic without affecting other groups.

**Real-world example:** one consumer group processes order payments, while another independent consumer group reads the same `orders` topic for real-time analytics. Both groups track their own offsets independently.

## Retention and Compaction

Kafka provides two primary mechanisms to manage stored event data:

### A. Retention — Deleting Old Data

Kafka retains messages for a configured duration or until configured topic/cluster storage limits apply.

- **Example:** if a topic has a retention period of 7 days, Kafka automatically purges messages older than 7 days.
- Even if a consumer has already read a message, Kafka preserves it until the retention policy renders it eligible for cleanup.

### B. Log Compaction — Keeping the Latest Value for Each Key

For keyed records, Kafka can preserve the latest record for each key while purging older, superseded records during compaction cycles.

**Example:** a topic tracks customer addresses with the primary key `customer_id`.

Before compaction:

| Key | Message |
|-----|---------|
| Customer 101 | Delhi |
| Customer 202 | Mumbai |
| Customer 101 | Jaipur |

After compaction:

| Key | Latest Message |
|-----|----------------|
| Customer 101 | Jaipur |
| Customer 202 | Mumbai |

> **Note:** the older address (Delhi) for Customer 101 is automatically removed during compaction.

> **Important:** Compaction does not delete older records instantly and is not a substitute for a backup strategy. Define replay windows and data recovery policies explicitly in object storage like Amazon S3.
