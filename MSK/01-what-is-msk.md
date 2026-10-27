# 1. What is Amazon MSK?

Amazon Managed Streaming for Apache Kafka (Amazon MSK) is an AWS managed service that helps us run Apache Kafka without managing all the Kafka infrastructure ourselves.

Think of Kafka as a messenger between applications. One application sends information, and other applications receive that information. Kafka is a distributed event-streaming platform where applications publish records (called events) to topics, and other applications read those records.

For example, events can represent an order being created, a payment being accepted, a device reporting a temperature, or a service generating a log.

AWS manages much of the Kafka infrastructure and cluster operations, while we are responsible for designing our applications and topics, configuring security and access policies, and managing how our applications send and receive events.

## What "distributed event streaming service" means

- **Distributed:** data and work are spread across multiple broker servers. This can improve throughput and resilience when designed correctly.
- **Event:** a record describing something that happened, usually with a key, value, timestamp, and optional headers.
- **Streaming:** events can be produced and processed continuously, often shortly after they occur.

## Why use MSK?

- **No Server Headaches:** AWS handles server maintenance and infrastructure management.
- **Loose Coupling:** services can communicate without crashing each other.
- **Reliable Buffering:** holds messages safely even if an application goes offline.
- **Easy Scaling:** easily scales processing using partitions and consumer groups.
- **AWS Integration:** seamlessly integrates with AWS services and Kafka ecosystem tools.

## What MSK does not do automatically

- It won't design your data structure, topics, schemas, partition keys, or retention policies.
- It doesn't prevent duplicate messages or make delivery exactly-once by default; your applications must handle retries safely.
- It doesn't handle your network routing, security groups, client authentication, or access permissions for you.
- It doesn't guarantee equal record counts across all partitions.
- It doesn't eliminate the need to monitor consumer lag, cluster capacity, and application errors.

## Use Cases of Kafka

Apache Kafka is used when applications need to send, receive, store, and process large amounts of data continuously in real time.

For example, when a customer places an order on an e-commerce platform like Amazon, multiple systems need to react to that event: payment processing, inventory management, shipping, notifications, and real-time analytics. Kafka allows these systems to exchange events seamlessly without communicating directly with each other.

### Real-world Use Case: E-commerce and Order Processing

When a customer places an order, the application publishes an `OrderCreated` event to Kafka:

- **Payment Service:** processes the payment for the order.
- **Inventory Service:** updates product stock levels.
- **Shipping Service:** prepares the item for fulfillment and delivery.
- **Notification Service:** sends a confirmation email or SMS to the customer.
- **Example Topic:** `orders`
