# 18. Hands-on lab: create, produce, consume, monitor, clean up

**Goal:** create a small test MSK environment, connect a client, write and read records, inspect metrics, and delete test resources. This lab is a workflow rather than a copy/paste guarantee: exact console options, endpoints, and CLI parameters depend on the current AWS CLI and MSK cluster configuration.

## Prerequisites

- An AWS account with permission to create/delete MSK and related IAM/network resources.
- A test VPC/subnets in the selected Region.
- AWS CLI configured with a least-privilege role.
- A client machine (for example EC2) with network access to the cluster.
- A plan to delete test resources and avoid unnecessary charges.

## Step 1 — Create a cluster

In the AWS console, open Amazon MSK and create a test cluster. Choose Provisioned or Serverless, select the supported Kafka version and required networking/security settings, and enable an authentication option. For a production cluster, use multi-AZ placement and a reviewed capacity design.

## Step 2 — Create a client

Launch or use a client in a network path that can reach the MSK endpoints. Install a compatible Java runtime and Kafka command-line tools, or use a supported language client. Configure credentials and TLS/IAM/SCRAM/mTLS exactly as selected on the cluster.

## Step 3 — Retrieve bootstrap brokers

Use the MSK console or the AWS CLI `describe-cluster-v2` response to retrieve bootstrap broker strings for the chosen authentication method. Never paste real credentials or sensitive endpoints into public tickets.

```bash
# Example command pattern; replace the cluster ARN and Region.
aws kafka describe-cluster-v2 \
  --cluster-arn "YOUR_CLUSTER_ARN" \
  --region "YOUR_REGION"
```

## Step 4 — Create a topic

Use the Kafka CLI with the correct bootstrap endpoint and client properties. The following is a conceptual command for a client already configured to authenticate.

```bash
kafka-topics.sh \
  --bootstrap-server YOUR_BOOTSTRAP_BROKERS \
  --command-config client.properties \
  --create \
  --topic orders \
  --partitions 3 \
  --replication-factor 3
```

The replication factor must be supported by the cluster's broker count and configuration. For a cluster with three brokers, RF=3 is a common learning example.

## Step 5 — Produce test events

```bash
kafka-console-producer.sh \
  --bootstrap-server YOUR_BOOTSTRAP_BROKERS \
  --producer.config client.properties \
  --topic orders
```

Type a few test lines, for example: `{"order_id":101,"status":"created"}`. The console producer treats each line as a record; it does not automatically validate JSON.

## Step 6 — Consume events

```bash
kafka-console-consumer.sh \
  --bootstrap-server YOUR_BOOTSTRAP_BROKERS \
  --consumer.config client.properties \
  --topic orders \
  --from-beginning
```

The client properties file must match the authentication method. For IAM authentication, use AWS's official configuration instructions; do not assume the generic file above is sufficient by itself.

## Step 7 — Inspect topics and consumer groups

```bash
kafka-topics.sh \
  --bootstrap-server YOUR_BOOTSTRAP_BROKERS \
  --command-config client.properties \
  --describe \
  --topic orders

kafka-consumer-groups.sh \
  --bootstrap-server YOUR_BOOTSTRAP_BROKERS \
  --command-config client.properties \
  --list
```

## Step 8 — Monitor

Open CloudWatch metrics for the MSK cluster. Review broker health, bytes in/out, CPU, storage, under-replicated/offline partitions where exposed, and consumer lag metrics available for your cluster configuration. Create alerts based on your test baseline.

## Step 9 — Cleanup

Delete the test topic if appropriate, delete the test cluster, and remove unused EC2 instances, security groups, roles/policies, log groups, secrets, and other resources created for the lab. Confirm that resources are actually deleted to prevent ongoing charges.
