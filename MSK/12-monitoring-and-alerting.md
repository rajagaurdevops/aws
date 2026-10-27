# 12. Monitoring, metrics, and alerting

Use Amazon CloudWatch and, where enabled/supported, open monitoring integrations such as Prometheus. Monitor both cluster infrastructure and application behavior. A cluster can look healthy while consumers fall behind or business processing fails.

| Area | What to monitor | Why it matters |
|------|-----------------|----------------|
| **Broker health** | Broker CPU, memory/JVM pressure where exposed, network, disk/storage usage | Find saturation before client failures. |
| **Partition health** | Under-replicated partitions, offline partitions, leader imbalance | Detect replication or availability problems. |
| **Producer** | Request latency, errors, retries, record send rate, throughput | Find failed or slow writes. |
| **Consumer** | Consumer lag, fetch rate, processing duration, commit errors | Find downstream bottlenecks. |
| **Capacity** | Bytes in/out, storage growth, partition count, connections | Forecast growth and scale in time. |
| **Business outcomes** | Orders processed, payment failures, end-to-end event age | Infrastructure metrics alone do not prove business correctness. |

## Suggested alerts

- Offline partitions greater than zero.
- Under-replicated partitions remain elevated beyond a short transient window.
- Consumer lag or oldest-event age exceeds the application's service-level objective.
- Broker CPU/network/storage approaches a sustained threshold.
- Producer error rate or request latency increases significantly.
- Authentication/authorization failures spike.
- Storage growth projects to exhaustion before the next planned action.

> Choose thresholds from workload baselines and SLOs rather than adopting universal values. Alert on sustained symptoms and include runbook links and owners.
