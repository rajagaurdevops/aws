# 13. Scaling, performance, and capacity planning

## Estimate retained data

A rough first estimate is:

```text
retained bytes ≈ average incoming bytes/second × retention seconds
```

Then account for replication, compression, indexes/overhead, traffic peaks, and safety margin. On provisioned clusters, broker storage and service pricing rules affect how this translates into cost.

**Example (uncompressed raw estimate):**

```text
Incoming rate      = 2 MB/s
Retention          = 24 hours = 86,400 seconds
Raw retained data  ≈ 2 MB/s × 86,400 s
                   ≈ 172,800 MB
                   ≈ 173 GB decimal (approximately)
```

Then add capacity margin and account for replication/compression and workload overhead.

## What affects performance?

- Record size and batch size.
- Compression codec and CPU availability.
- Number of partitions and whether they are balanced.
- Producer acknowledgment, retry, idempotence, and in-flight settings.
- Consumer processing speed, downstream database/API latency, and commit behavior.
- Broker CPU, network, storage throughput, and cross-AZ or cross-Region traffic.
- Hot keys that send a disproportionate share of records to one partition.

## Practical tuning sequence

1. Measure baseline throughput, latency, errors, and lag.
2. Find the limiting resource before changing settings.
3. Check hot partitions, keys, large records, and consumer processing time.
4. Tune batching/compression and application concurrency in a test environment.
5. Scale brokers or consumers only after validating partition layout and resource saturation.
6. Compare results against an SLO and record the change.
