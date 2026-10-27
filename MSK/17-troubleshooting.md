# 17. Troubleshooting playbook

| Symptom | Likely causes | Checks / actions |
|---------|---------------|------------------|
| Cannot connect | Wrong endpoint, DNS/routes/security groups, wrong port/auth endpoint, client outside VPC path. | Verify bootstrap brokers, DNS resolution, routes, security-group rules, TLS, and client network path. |
| Access denied | Missing IAM Kafka permissions, wrong topic/group ARN, wrong auth mechanism, ACL mismatch. | Check cluster authentication, client identity, IAM policy and cluster policy, topic/group resources, and broker endpoint type. |
| Producer timeout | Network path, broker overload, unavailable partitions, retry/timeout settings. | Check client logs, broker metrics, partition leader/replication health, latency, and connectivity. |
| Consumer receives no records | Wrong topic, wrong group offset, no new data, filtering/serialization issue, partition assignment issue. | Confirm topic, offsets, consumer group assignment, committed offsets, and producer success. |
| Consumer lag grows | Consumer too slow, downstream dependency slow, too few consumers relative to partitions, hot partition. | Measure processing time, lag per partition, downstream latency, partition skew, and consumer errors. |
| Under-replicated partitions | Broker/network issue, replica falling behind, resource saturation. | Check broker health and throughput, network, storage, maintenance, and replication metrics. |
| Uneven traffic | Hot key, key distribution skew, producer partitioning choice. | Inspect per-partition traffic and keys; revise key design or partitioning strategy carefully. |
| Duplicate processing | At-least-once delivery, retry, crash before offset commit, non-idempotent side effect. | Use idempotency keys, transaction/outbox patterns where appropriate, and explicit offset/processing semantics. |
| Storage grows unexpectedly | Retention too long, higher ingress, large messages, insufficient compaction/cleanup expectations. | Inspect topic retention/cleanup policy, ingress, record size, replication and actual stored bytes. |

## Incident triage order

1. Identify scope: one client, one topic, one broker, one AZ, or the whole cluster.
2. Check recent deployments, configuration changes, scaling, and network/security changes.
3. Inspect CloudWatch and client-side logs at the same timestamps.
4. Check partition leaders, offline/under-replicated partitions, and consumer group lag.
5. Restore service safely; avoid deleting topics or resetting offsets as a first reaction.
6. Record root cause, customer impact, remediation, and prevention actions.
