# 10. Topic design and event schemas

## Topic naming

- Use names that reflect business events or data domains, such as `orders`, `payments`, `inventory-changes`, or `telemetry`.
- Define ownership, retention, data classification, and intended consumer groups.
- Avoid creating a topic per user or per individual request unless the design specifically requires it.

## Event envelope

A useful event commonly includes a type, event ID, timestamp, schema version, and business payload. The precise contract depends on the system.

```json
{
  "event_id": "evt-7b9c",
  "event_type": "OrderCreated",
  "schema_version": 1,
  "occurred_at": "2026-10-23T12:00:00Z",
  "order_id": "order-101",
  "customer_id": "customer-101",
  "amount": 55000,
  "currency": "INR"
}
```

## Schema evolution

- Define whether fields are required or optional and provide safe defaults where appropriate.
- Use compatibility rules so a new producer does not break old consumers unexpectedly.
- Consider AWS Glue Schema Registry or another schema registry for supported formats and governance.
- Do not silently change the meaning or data type of an existing field.

## Choosing a partition key

Choose a key that distributes load while preserving the ordering needed by the business. `order_id` is useful for per-order ordering; `customer_id` may cause a hot partition if one customer generates a disproportionate amount of traffic. A null key may improve distribution in some cases but does not provide per-entity ordering.
