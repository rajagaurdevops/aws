# 6. MSK deployment options and choosing a cluster

| Option | Best fit | Key consideration |
|--------|----------|-------------------|
| **MSK Provisioned – Standard brokers** | Workloads needing broker/storage controls and broad configuration flexibility. | You choose broker count/type, storage, partitions, and capacity; monitor and scale deliberately. |
| **MSK Provisioned – Express brokers** | Supported workloads that benefit from higher throughput and faster scaling/recovery characteristics. | Check regional/version/feature availability and current pricing; capabilities differ from Standard. |
| **MSK Serverless** | Workloads where AWS-managed capacity scaling is preferred. | Capacity management is simplified, but throughput, partition, connectivity, and pricing limits still need review. |
| **MSK Connect** | Managed Kafka Connect workers for moving data between Kafka and external systems. | Connector compatibility, worker sizing, IAM, networking, and source/sink semantics matter. |
| **MSK Replicator** | Replicating Kafka data between supported MSK clusters/Regions. | Plan replication scope, latency, consumer offset behavior, and cross-Region costs. |

Choose based on traffic profile, latency, availability, operational control, regional support, integrations, and total cost — not solely on the smallest broker size.

## Standard vs Serverless (simple comparison)

- **Provisioned:** you choose and manage broker capacity and storage settings; useful when predictable control and tuning are important.
- **Serverless:** AWS manages the underlying broker capacity and scales resources to workload demand; review its supported limits, networking, and metered cost model.

> Express is a Provisioned broker type, not a synonym for Serverless.
