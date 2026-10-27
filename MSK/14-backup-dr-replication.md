# 14. Backup, replay, disaster recovery, and replication

## Replay

Kafka's retained log allows a consumer group to reread records by resetting offsets or using a new group, as long as the required records still exist. Replay can repeat side effects, so use idempotency and a controlled replay plan.

## Disaster recovery

- Define RPO (acceptable data loss) and RTO (acceptable recovery time).
- Consider MSK Replicator or a supported Kafka replication pattern for cross-cluster/Region needs.
- Test failover, DNS/config changes, client bootstrap updates, offset/consumer behavior, and application idempotency.
- Replication is not a backup of all business states; keep independent backups for downstream databases and other systems.

## Replication cautions

Cross-cluster replication introduces lag and additional data-transfer/storage cost. Decide which topics to replicate, how topic names are mapped, how consumer groups resume, and how to avoid processing the same business event twice after failover.
