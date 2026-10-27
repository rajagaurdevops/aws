# AWS MSK — Complete Learning and Operations Guide

**Concepts • Architecture • Security • Producers and Consumers • Operations • Troubleshooting • Hands-on Labs**

Prepared for AWS / DevOps learning
Updated: 23 October 2026

> Learning guide — verify region-specific options, versions, and pricing in the [official AWS documentation](21-references.md) before running commands or making production changes.

## How to use this guide

This guide explains Amazon Managed Streaming for Apache Kafka (Amazon MSK) from beginner concepts to practical operations. It is intended for learners, application developers, cloud engineers, and DevOps/platform engineers.

AWS MSK capabilities, supported Kafka versions, instance families, regional availability, CLI parameters, and pricing change over time. Treat the official AWS links in the [References](21-references.md) section as the source of truth before using a command or making a production change.

## Learning path

1. Understand events, topics, partitions, brokers, offsets, consumer groups, and replication.
2. Understand how MSK fits into a VPC and how clients connect.
3. Choose Provisioned Standard, Provisioned Express, or Serverless based on workload requirements.
4. Build producer and consumer applications and learn how keys affect partition selection.
5. Apply authentication, authorization, encryption, monitoring, scaling, and recovery practices.
6. Complete the hands-on lab and use the operations checklist before production.

## Contents

| # | Section | File |
|---|---------|------|
| 1 | What is Amazon MSK? | [01-what-is-msk.md](01-what-is-msk.md) |
| 2 | Kafka fundamentals and glossary | [02-kafka-fundamentals.md](02-kafka-fundamentals.md) |
| 3 | Cluster architecture and data flow | [03-cluster-architecture.md](03-cluster-architecture.md) |
| 4 | Topics, partitions, keys, offsets, and consumer groups | [04-topics-partitions-consumer-groups.md](04-topics-partitions-consumer-groups.md) |
| 5 | Replication, durability, and availability | [05-replication-durability.md](05-replication-durability.md) |
| 6 | MSK deployment options and choosing a cluster | [06-deployment-options.md](06-deployment-options.md) |
| 7 | Networking and connectivity | [07-networking.md](07-networking.md) |
| 8 | Security: authentication, authorization, and encryption | [08-security.md](08-security.md) |
| 9 | Producers and consumers: code patterns | [09-producers-and-consumers.md](09-producers-and-consumers.md) |
| 10 | Topic design and event schemas | [10-topic-design-and-schemas.md](10-topic-design-and-schemas.md) |
| 11 | Operations and cluster lifecycle | [11-operations.md](11-operations.md) |
| 12 | Monitoring, metrics, and alerting | [12-monitoring-and-alerting.md](12-monitoring-and-alerting.md) |
| 13 | Scaling, performance, and capacity planning | [13-scaling-and-performance.md](13-scaling-and-performance.md) |
| 14 | Backup, replay, disaster recovery, and replication | [14-backup-dr-replication.md](14-backup-dr-replication.md) |
| 15 | MSK Connect and integration patterns | [15-msk-connect.md](15-msk-connect.md) |
| 16 | Cost model and cost optimization | [16-cost.md](16-cost.md) |
| 17 | Troubleshooting playbook | [17-troubleshooting.md](17-troubleshooting.md) |
| 18 | Hands-on lab: create, produce, consume, monitor, clean up | [18-hands-on-lab.md](18-hands-on-lab.md) |
| 19 | Production readiness checklist | [19-production-checklist.md](19-production-checklist.md) |
| 20 | Interview questions and answers | [20-interview-questions.md](20-interview-questions.md) |
| 21 | Official references | [21-references.md](21-references.md) |
