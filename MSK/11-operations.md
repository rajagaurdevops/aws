# 11. Operations and cluster lifecycle

## Provisioning workflow

1. Define throughput, retention, latency, durability, compliance, and recovery requirements.
2. Choose Provisioned Standard, Provisioned Express, or Serverless after checking regional support and current limits.
3. Choose VPC/subnets/AZs, authentication, encryption, broker sizing or capacity, and storage settings.
4. Create the cluster and wait for the active/ready state.
5. Retrieve the correct bootstrap brokers for the chosen authentication method.
6. Configure IAM/ACL permissions and client networking.
7. Create topics with an intentional partition count, replication factor, and retention policy.
8. Test produce/consume behavior, failure recovery, metrics, and alarms.
9. Document ownership, upgrades, scaling, incident response, and cleanup.

## Cluster configuration vs topic configuration

Cluster configuration controls broker-level defaults and behavior. Topic configuration controls settings for an individual topic where supported. Changes should be reviewed, versioned, and tested; not every setting can be changed dynamically or without operational impact.

## Upgrades and maintenance

- Review supported Kafka versions and upgrade paths in the current AWS guide.
- Test client compatibility and application behavior in a non-production environment first.
- Check partition replication health and consumer lag before maintenance.
- Use a change plan with monitoring and rollback/mitigation steps.

## Scaling

- **Broker scaling:** change broker size/family or broker count where supported and appropriate.
- **Storage scaling:** increase provisioned storage or configure supported storage autoscaling where applicable.
- **Partition scaling:** increasing partitions can improve parallelism but may change key-to-partition mapping and ordering assumptions.
- **Consumer scaling:** add consumers up to the number of partitions for the topic/group; beyond that, additional consumers may be idle.
- **Serverless:** AWS manages the underlying capacity, but customers still need to control partition count, workload, and consumption patterns.
