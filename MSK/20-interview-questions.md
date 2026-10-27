# 20. Interview questions and answers

**Q: What is AWS MSK?**
A: A managed AWS service for running Apache Kafka clusters and Kafka streaming applications.

**Q: What is a broker?**
A: A Kafka server that stores partition replicas and serves producer/consumer requests.

**Q: What is a topic?**
A: A named stream/category of records.

**Q: What is a partition?**
A: An ordered log within a topic that enables parallelism and distributes storage.

**Q: If a topic has 3 partitions and RF=3, how many replicas exist?**
A: There are 3 logical partitions and 9 partition replicas in total.

**Q: Does Kafka guarantee 300/300/300 records when sending 900 records to 3 partitions?**
A: No. Distribution depends on keys and the partitioning strategy.

**Q: What is an offset?**
A: A record position within one partition, used by consumers to track progress.

**Q: What is a consumer group?**
A: A set of consumers sharing topic partitions and maintaining group offsets.

**Q: Can two consumers in the same group read the same partition simultaneously?**
A: Normally no; a partition is assigned to at most one consumer in a group at a time.

**Q: Can two different consumer groups read the same topic?**
A: Yes. Each group tracks its own progress.

**Q: What is consumer lag?**
A: The gap between the latest available records and the consumer group's progress.

**Q: What is a hot partition?**
A: A partition receiving disproportionate traffic, often because of skewed keys.

**Q: What is the difference between RF and partition count?**
A: Partition count is the number of logical logs; RF is the number of copies of each log.

**Q: Does MSK always use ZooKeeper?**
A: No. Kafka metadata architecture depends on the supported Kafka version and cluster mode; KRaft replaces ZooKeeper in KRaft-based clusters.

**Q: What does `acks=all` mean?**
A: The producer waits for acknowledgment according to the in-sync replica requirements and broker/topic settings.

**Q: What is MSK Connect?**
A: A managed way to run Kafka Connect connectors for moving data to/from Kafka.

**Q: What is MSK Replicator?**
A: A managed capability for replicating data between supported MSK clusters.

**Q: How do you secure MSK?**
A: Use private networking, supported authentication, least-privilege authorization, TLS, encryption at rest, and secret hygiene.

**Q: Why can consumer lag increase?**
A: Consumers may be slow, downstream services may be slow, partitions may be skewed, or there may be too few consumers for the workload.

**Q: How do you reduce duplicates?**
A: Design idempotent processing and choose suitable offset/transaction patterns; do not assume end-to-end exactly-once automatically.
