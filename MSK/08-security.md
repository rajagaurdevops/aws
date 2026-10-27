# 8. Security: authentication, authorization, and encryption

Use defense in depth: network isolation, encryption, authentication, authorization, secret handling, logging, and controlled administration. AWS secures the underlying managed service infrastructure; customers remain responsible for identities, policies, application security, and data governance.

## Authentication options

| Method | Concept | Operational note |
|--------|---------|------------------|
| **IAM access control** | AWS IAM identities authenticate and Kafka permissions are authorized through IAM. | Common for AWS-native workloads; use least-privilege identity policies and the correct client mechanism. |
| **SASL/SCRAM** | Clients authenticate with a username/password stored through the supported MSK secret integration. | Protect credentials, rotate them, and avoid placing them in source code. |
| **Mutual TLS (mTLS)** | Clients authenticate using certificates. | Manage certificate issuance, rotation, trust, and revocation. |
| **TLS encryption** | Encrypts traffic in transit. | TLS is encryption; by itself it is not necessarily the full client authentication/authorization scheme. |

## Authorization

- **IAM access control:** grant only the required cluster-connect, topic read/write/create, and consumer-group permissions.
- **Kafka ACLs:** used with supported authentication configurations such as SCRAM or mTLS, depending on cluster setup.
- Separate producer and consumer identities; a producer should not automatically have broad read or cluster-admin permissions.
- For cross-account access, review the MSK cluster policy and client identity policy together.

## Encryption

- **In transit:** use TLS/SASL_SSL endpoints where applicable and verify client configuration.
- **At rest:** MSK supports encryption at rest, with AWS-managed or customer-managed KMS key choices where supported.
- **Secrets:** store credentials in an approved secret store, rotate them, and never commit secrets to Git.

## IAM client permission checklist

- Can the client obtain AWS credentials through an instance/task/pod role or another approved mechanism?
- Does its IAM policy permit the necessary MSK cluster connection and Kafka data-plane operations?
- Does the topic/resource ARN and consumer-group ARN match the intended resources?
- Is the cluster configured for IAM access control and is the client using the matching bootstrap endpoint?
- Can the client reach the broker endpoints over the network?
