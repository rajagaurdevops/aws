# 5. Replication, Durability, and Availability

## Leader and follower replicas

Think of a partition like a logbook being maintained by a team:

- **The Leader:** one broker acts as the "Leader" for that partition. Every time a producer writes a new message or a consumer reads data, they interact directly with this leader.
- **The Followers:** the other brokers act as "Followers." They silently watch the leader and constantly copy down everything the leader writes so they have an exact duplicate of the data.
- **Automatic Failover:** if the broker holding the leader crashes or loses network connection, Kafka automatically promotes one of the healthy followers to become the new leader so service continues without interruption.

## Replication

Instead of keeping all your important information in just one place, Kafka creates multiple copies (replicas) of every data partition and spreads them across different machines or Availability Zones.

Here is why replication is so important:

- **Backup & Safety:** if one server crashes or an entire data center goes offline, your data isn't lost because the other servers have an exact copy.
- **High Availability:** since multiple servers hold the data, the system can quickly switch to a backup copy and keep running without any downtime.

## Replication Factor

The replication factor (RF) defines the total number of copies Kafka maintains for each partition across different brokers in a cluster to ensure high availability and fault tolerance.

### Replication Examples

- **Replication Factor = 1:** only 1 copy of each partition exists. If the hosting broker crashes, the partition data becomes unavailable until the broker recovers.
- **Replication Factor = 3:** 3 copies (1 leader and 2 followers) are distributed across 3 distinct brokers/AZs for maximum durability and uninterrupted availability.

## Partition Replica Distribution (3 Partitions, RF=3, 3 Brokers)

| Partition | Broker 1 | Broker 2 | Broker 3 |
|-----------|----------|----------|----------|
| Partition 0 | Leader | Follower | Follower |
| Partition 1 | Follower | Leader | Follower |
| Partition 2 | Follower | Follower | Leader |

**Total Partition Replicas Calculation:**

```text
Total Replicas = Number of Partitions × Replication Factor
Total Replicas = 3 partitions × 3 replicas = 9 total partition replicas
```

stored across the cluster.

**Automatic Leader Election on Broker Failure:** if Broker 1 fails, Kafka automatically elects an in-sync follower on Broker 2 or Broker 3 to become the new leader for Partition 0, ensuring zero downtime for client operations.

> **Important Note:** To ensure maximum durability with RF=3, producers should use `acks=all` along with a topic configuration of `min.insync.replicas=2`. This ensures messages are acknowledged only when stored across at least two in-sync replicas before returning success.
