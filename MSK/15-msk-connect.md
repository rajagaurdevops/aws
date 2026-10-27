# 15. MSK Connect and integration patterns

MSK Connect is a managed service for running Kafka Connect connectors. Connectors can ingest data from external systems into Kafka (source connectors) or export Kafka data to external systems (sink connectors). Connector support and compatibility must be checked before deployment.

| Pattern | Example |
|---------|---------|
| Application to Kafka | Checkout API publishes `OrderCreated` events. |
| Kafka to application | Fulfillment service consumes orders. |
| Database CDC to Kafka | A connector streams database changes into Kafka. |
| Kafka to object storage | A sink writes event batches to S3. |
| Kafka to analytics | Stream processing or analytics reads events. |
| Cross-cluster replication | MSK Replicator copies supported Kafka data between clusters. |

Use a connector when a supported integration is more maintainable than custom polling code. Review connector task parallelism, retries, dead-letter behavior, IAM, networking, and data consistency semantics.
