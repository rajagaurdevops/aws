# 7. Networking and connectivity

MSK clusters are normally reached through private networking. A client must be able to resolve and connect to the correct bootstrap/broker endpoints. A working IAM policy alone does not fix a VPC routing or security-group problem.

## Network checklist

- Select VPC subnets across the required Availability Zones and check available IP address capacity.
- Allow client-to-broker traffic in the relevant security groups for the selected authentication/transport configuration.
- Verify route tables, network ACLs, DNS resolution, and any Transit Gateway, peering, VPN, or Direct Connect paths.
- For clients in another VPC/account, configure an explicitly supported connectivity pattern such as MSK multi-VPC private connectivity or an appropriate network design.
- Avoid public access unless it is specifically required and secured; prefer private access for internal applications.
- Use the bootstrap broker string that matches the cluster's enabled authentication method.

## Common connectivity patterns

- **EC2/ECS/EKS in the same VPC:** private broker endpoints with security-group and IAM/SASL/TLS configuration.
- **On-premises client:** private network path through VPN or Direct Connect, DNS resolution, routes, and firewall rules.
- **Cross-account/cross-VPC:** supported private connectivity and cluster policies, or an architecture-approved network path.

> Port numbers and bootstrap endpoint formats vary with the authentication option and cluster setup. Retrieve the actual endpoints from the MSK console or AWS CLI; do not guess them.
