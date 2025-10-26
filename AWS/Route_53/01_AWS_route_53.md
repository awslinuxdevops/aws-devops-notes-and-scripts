#  AWS Route 53 — Complete Notes
 
**What is Amazon Route 53?**

Amazon Route 53 is a **highly available and scalable Domain Name System (DNS)** web service by AWS.
It is used to route end-user requests to internet applications running on AWS or other infrastructures.

📡 In simple terms: Route 53 connects domain names → IP addresses (e.g., example.com → 192.0.2.1).

| **Component**                     | **Description**                                                                 |
| ----------------------------- | --------------------------------------------------------------------------- |
| **Hosted Zone**               | A container that holds DNS records for a domain.                            |
| **Record Sets (DNS Records)** | Mapping between domain names and resources (like EC2, Load Balancer, etc.). |
| **Health Checks**             | Monitors the health of resources and routes traffic only to healthy ones.   |
| **Domain Registration**       | Route 53 can register domain names (e.g., example.com).                     |
| **Traffic Flow**              | Advanced routing policies using geolocation, latency, and failover routing. |

| **Type**                    | **Description**                                           | **Example**                    |
| ----------------------- | ----------------------------------------------------- | -------------------------- |
| **Public Hosted Zone**  | Used for public domains accessible from the internet. | `global_example.com`            |
| **Private Hosted Zone** | Used for internal domains inside a VPC.               | `internal.example.local` |


### Common Record Types

| **Record Type**                  | **Description**                                                       | **Example**                                 |
| ---------------------------- | ----------------------------------------------------------------- | --------------------------------------- |
| **A (Address)**              | Maps domain to IPv4 address.                                      | `app.example.com → 13.232.22.1`       |
| **AAAA**                     | Maps domain to IPv6 address.                                      | `api.example.com → 2607:f0d0:1002::4` |
| **CNAME**                    | Alias for another domain.                                         | `www.example.com → example.com`     |
| **MX (Mail Exchange)**       | Used for mail servers.                                            | `10 mail.example.com`                 |
| **TXT**                      | Used for verification, SPF, DKIM records.                         | `"v=spf1 include:amazonses.com ~all"`   |
| **NS (Name Server)**         | Delegates DNS authority.                                          | `ns-123.awsdns-45.com`                  |
| **SOA (Start of Authority)** | Contains admin info about the zone.                               | Automatically created by AWS.           |
| **Alias Record**             | AWS-specific pointer to AWS resources (like ELB, S3, CloudFront). | `app.example.com → ALIAS to ELB`      |

### Routing Policies in Route 53

| **Policy**                        | **Description**                                               | **Use Case**                              |
| ----------------------------- | --------------------------------------------------------- | ------------------------------------- |
| **Simple Routing**            | Routes to a single resource.                              | Basic website.                        |
| **Weighted Routing**          | Distributes traffic based on weights.                     | A/B testing, canary deployments.      |
| **Latency Routing**           | Routes to region with lowest latency.                     | Global applications.                  |
| **Failover Routing**          | Primary & secondary setup.                                | Disaster recovery setups.             |
| **Geolocation Routing**       | Based on user’s location (continent/country).             | Region-specific content.              |
| **Geoproximity Routing**      | Routes based on geographic proximity (with bias control). | Advanced traffic optimization.        |
| **Multivalue Answer Routing** | Returns multiple IPs for load balancing.                  | Simple load balancing across servers. |





### 🧭 Real-Time Example
Example Scenario — Hosting a Web App

Goal: Host app.example.com using an EC2 instance and an Application Load Balancer (ALB).

**Steps:**

Domain Registration
Buy domain example.com in Route 53.

Public Hosted Zone
Create a hosted zone for example.com.

Create Alias Record

Record name: app.example.com

Type: A - IPv4

Alias: Yes

Alias Target: my-alb-123456.ap-south-1.elb.amazonaws.com

Test

**nslookup app.example.com**
```curl https://app.example.com```


✅ Output: Application loads from ALB → EC2 → App.


### Real-Time Use Cases (DevOps Perspective)
| **Use Case**                      | **Description**                                                                 |
| ----------------------------- | --------------------------------------------------------------------------- |
| **Blue-Green Deployment**     | Weighted routing between two versions of an app (e.g., v1 - 80%, v2 - 20%). |
| **Failover Setup**            | Route traffic to secondary region when primary is down.                     |
| **Private DNS in VPC**        | Create internal DNS names like `db.internal.example.local`.               |
| **HTTPS Setup**               | Integrate Route 53 + ACM (Certificate Manager) + CloudFront for SSL/TLS.    |
| **S3 Static Website Hosting** | Use Alias record to route domain to S3 website endpoint.                    |


### Route 53 with Other AWS Services
|**AWS Service**                | **Integration Use**                            |
| -------------------------- | ------------------------------------------ |
| **S3**                     | Host static website via alias record.      |
| **CloudFront**             | CDN for domain using Route 53 alias.       |
| **ALB / NLB**              | Alias record for load balancers.           |
| **EC2 / EKS**              | Route domain to public IP or ELB endpoint. |
| **API Gateway**            | Custom domain for APIs.                    |
| **ACM (SSL Certificates)** | Secure your domain with HTTPS.             |

### 🧑‍💻 CLI Commands
List Hosted Zones
aws route53 list-hosted-zones
```
Create Record Set
aws route53 change-resource-record-sets \
  --hosted-zone-id Z123456789 \
  --change-batch file://recordset.json
```
**Example recordset.json**
```
{
  "Comment": "Add A record for app.example.com",
  "Changes": [
    {
      "Action": "UPSERT",
      "ResourceRecordSet": {
        "Name": "app.example.com",
        "Type": "A",
        "AliasTarget": {
          "HostedZoneId": "Z35SXDOTRQ7X7K",
          "DNSName": "my-alb-123456.ap-south-1.elb.amazonaws.com",
          "EvaluateTargetHealth": false
        }
      }
    }
  ]
}
```
### 🔍 Health Checks

**Route 53 health checks monitor:**

- HTTP(S) endpoints

- TCP ports

- CloudWatch alarms

If a resource fails health check, Route 53 can automatically failover to another healthy endpoint.

###  🧪 Troubleshooting Tips
| **Issue**                   | **Check**                                               |
| ----------------------- | --------------------------------------------------- |
| Domain not resolving    | Verify NS records at registrar.                     |
| Alias to S3 not working | Ensure static hosting enabled in S3.                |
| HTTPS not loading       | Verify ACM certificate and CloudFront distribution. |
| Health check failing    | Check endpoint response code (must be 2xx or 3xx).  |

### 🧩 Route 53 creation in Terraform


**Automate record creation via Terraform or CloudFormation.**
```
# 🪶 Terraform Example for Route 53 Record
resource "aws_route53_record" "app_record" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "app.example.com"
  type    = "A"

  alias {
    name                   = aws_lb.app_alb.dns_name
    zone_id                = aws_lb.app_alb.zone_id
    evaluate_target_health = false
  }
}
```