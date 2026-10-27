# 16. Cost model and cost optimization

MSK pricing depends on cluster type and region. Always use the official pricing page and AWS Pricing Calculator for current rates. Do not assume one price applies to all Regions or broker types.

## Common cost dimensions

- Provisioned broker hours and broker type/size.
- Provisioned storage and, where applicable, extra storage throughput.
- For Express brokers, data ingestion charges and the relevant storage/broker charges.
- For Serverless, cluster time, partition time, data written/read, and storage according to the current pricing model.
- MSK Connect worker/MCU usage and MSK Replicator charges, when used.
- Data transfer, PrivateLink/private connectivity, CloudWatch, KMS, S3, and downstream service costs where applicable.

## Cost optimization checklist

- Right-size broker capacity using observed throughput and headroom, not guesswork.
- Set retention to the business replay requirement; avoid keeping everything indefinitely without a reason.
- Avoid excessive partition counts and unnecessary topics.
- Use compression and appropriate batching when suitable.
- Review idle clusters and non-production schedules.
- Estimate cross-AZ, cross-Region, PrivateLink, connector, and downstream costs.
- Revisit costs after traffic or retention changes.
