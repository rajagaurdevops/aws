# 3. Cluster Architecture and Data Flow

An Amazon MSK Provisioned cluster consists of multiple Kafka brokers distributed across subnets in different AWS Availability Zones (AZs). A broker is a Kafka server that stores and manages event data.

Kafka divides topic data into partitions and can store replicas of those partitions on different brokers. The partition leader handles reads and writes, while follower replicas copy data from the leader. Replication helps protect data availability if a broker or Availability Zone fails.

## How data flows through an MSK cluster

1. A producer sends an event, such as `OrderCreated`, to a Kafka topic.
2. Kafka routes the event to the appropriate partition leader.
3. The leader stores the event and replicates it to follower replicas according to the cluster's replication configuration.
4. Consumers read events from the topic and process them according to their application's needs.
5. Kafka tracks each consumer group's reading progress using offsets.

## How Kafka manages cluster metadata

Kafka also needs to maintain metadata about brokers, topics, partitions, and partition leaders. The metadata management architecture depends on the Kafka version and cluster mode:

- **ZooKeeper-based architecture:** older Kafka deployments use ZooKeeper for cluster coordination and metadata management.
- **KRaft-based architecture:** Kafka uses its own controller quorum to manage metadata, without requiring ZooKeeper.

> **Important:** Not every Amazon MSK cluster uses ZooKeeper. The metadata architecture depends on the Kafka version and cluster mode supported by the deployment.

### What Are ZooKeeper and KRaft?

ZooKeeper and KRaft are systems used to manage Kafka cluster metadata and coordinate brokers. They help Kafka track brokers, manage partition leadership, and respond to cluster changes and failures.

- **ZooKeeper:** a separate coordination system used by older Kafka clusters.
- **KRaft:** Kafka's built-in metadata management and coordination system that replaces ZooKeeper.

> **Important:** Neither system stores your application's Kafka messages. Kafka brokers store and serve those messages.

### What Is ZooKeeper?

ZooKeeper is a separate service that older Kafka architectures use to coordinate the Kafka cluster.

**What does ZooKeeper do?**

- Tracks broker membership and helps detect broker failures.
- Maintains cluster coordination information.
- Supports partition-leader coordination in the older Kafka architecture.
- Helps Kafka respond to changes in the cluster.

**Example:** suppose a Kafka cluster has three brokers:

- Broker 1 is the leader for a partition.
- Broker 2 and Broker 3 hold follower replicas.
- Broker 1 crashes.

ZooKeeper helps the older architecture detect the broker failure. Kafka then coordinates the election of an eligible replica as the new partition leader.

**Who manages ZooKeeper?** The DevOps or platform team typically deploys, configures, monitors, and maintains the separate ZooKeeper cluster, along with the Kafka infrastructure.

### What Is KRaft?

KRaft stands for Kafka Raft. It is Kafka's built-in system for managing cluster metadata using the Raft consensus protocol. It removes the need for a separate ZooKeeper cluster.

**What does KRaft do?**

- Manages metadata about topics, partitions, brokers, and cluster configurations.
- Elects and manages the active controller.
- Coordinates partition leadership and metadata changes.
- Maintains metadata through a replicated controller quorum.
- Allows another controller to take over if the active controller fails, provided a majority of the quorum remains available.

**Example:** suppose a Kafka cluster has three KRaft controllers:

- Controller 1 is the active controller.
- Controllers 2 and 3 are available to participate in controller elections.
- Controller 1 fails.

The remaining controllers can elect a new active controller because two out of three controllers form a majority.

**Who manages KRaft?** The DevOps or platform team configures and maintains the Kafka cluster, including its controller nodes, broker nodes, networking, storage, security, and monitoring. Kafka automatically handles controller elections and metadata coordination.

> **Note:** Kafka 4.0 removed ZooKeeper mode. Kafka 4.x clusters use KRaft.

## Kafka Brokers vs Controllers

- **Broker:** stores topic partitions and handles producer and consumer requests.
- **Controller:** manages cluster metadata, partition assignments, and leadership changes.
- **ZooKeeper:** provides external coordination for older Kafka clusters.
- **KRaft:** provides Kafka's built-in metadata and controller coordination.

In KRaft mode, controllers and brokers can run on separate nodes or share nodes, depending on the deployment configuration.

## Managed Kafka

With a service such as Amazon MSK, AWS manages much of the underlying infrastructure and service operations. The application or platform team remains responsible for cluster configuration, security, capacity planning, and monitoring.

> **Interview answer:** ZooKeeper was used by older Kafka clusters for coordination and metadata management. KRaft replaces ZooKeeper with Kafka's built-in controller quorum, using the Raft consensus protocol. This simplifies the architecture by removing the separate ZooKeeper dependency.

## Conceptual diagram

```text
Producer service
       |
       | bootstrap endpoint + TLS/authentication
       v
MSK broker cluster (inside VPC)
  |-- Topic: orders
  |     |-- Partition 0: leader on Broker A; replicas on B/C
  |     |-- Partition 1: leader on Broker B; replicas on A/C
  |     |-- Partition 2: leader on Broker C; replicas on A/B
  |
  +--> Consumer group: order-processing
  +--> Consumer group: analytics
```

The diagram is illustrative. Actual partition placement, leaders, replica assignments, and endpoints are determined by the cluster and Kafka configuration.
