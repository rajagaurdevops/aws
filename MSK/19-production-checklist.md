# 19. Production readiness checklist

- [ ] Business owner, technical owner, data classification, and incident contact are documented.
- [ ] Capacity is based on measured ingress, egress, record size, retention, and peak traffic.
- [ ] Partition count, key, replication factor, retention, and cleanup policy are documented.
- [ ] Producer retry, idempotence, acknowledgments, timeouts, batching, and compression are tested.
- [ ] Consumer group, offset commit strategy, rebalance behavior, and idempotency are tested.
- [ ] Network routes, security groups, DNS, and cross-VPC connectivity are verified.
- [ ] Authentication and authorization use least privilege; secrets and certificates have rotation plans.
- [ ] Encryption at rest and in transit meet policy requirements.
- [ ] Dashboards and alerts cover broker health, replication, lag, producer errors, and business outcomes.
- [ ] Recovery, replay, failover, and data-loss scenarios have been exercised.
- [ ] Kafka/MSK version upgrades and maintenance have a tested procedure.
- [ ] Costs are forecast and monitored; unused resources have an owner and cleanup policy.
- [ ] Runbooks describe safe triage and explicitly warn against destructive offset/topic actions.
