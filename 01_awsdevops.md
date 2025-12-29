# AWS INTERVIEW NOTES


**1. Amazon EC2 (Elastic Compute Cloud)**

EC2 provides resizable virtual machines in AWS cloud, allowing you to choose instance types based on CPU, memory, and storage requirements.

Each instance runs in an isolated environment and can be connected to the internet or a private subnet.

Commonly used for hosting applications, Jenkins servers, or backend services in DevOps pipelines.

**Real-time Use Case:**
In most DevOps setups, Jenkins or Docker registry runs on EC2 instances. EC2 uses IAM roles to securely access S3 or ECR without credentials.

**Interview Tip:**
Be ready to explain EC2 types (On-Demand, Spot, Reserved) and how Auto Scaling and Load Balancing work with EC2.



### Common Interview Questions

| Question                                        | Answer                                                                                                                                    |
| ----------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| How do you connect to an EC2 instance?          | Using SSH (Linux) or RDP (Windows) with key pair. Example: `ssh -i key.pem ec2-user@public_ip`                                            |
| How to make EC2 secure?                         | Disable root login, enable IAM role-based access, restrict ports, enable CloudWatch alerts.                                               |
| Difference between Stop, Terminate, and Reboot? | **Stop:** Instance stops but EBS volume persists. **Terminate:** Instance + EBS deleted. **Reboot:** Restarts instance without data loss. |



 **2. IAM (Identity and Access Management)**
🔹 What is IAM?

IAM manages users, groups, roles, and permissions securely in AWS.

Controls who can access which services and actions.

🔹 Real-time Scenario:

Assign EC2 instances an IAM Role to access S3 or ECR without using access keys.

### 🔹 Common Interview Questions 

| Question                              | Answer                                                                                                |
| ------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| Difference between IAM User and Role? | User = human identity, Role = temporary credentials for AWS services.                                 |
| How do you enforce MFA?               | Enable MFA (Multi-Factor Auth) for console users in IAM settings.                                     |
| How to give limited access to a user? | Attach custom policy with specific service actions. Example: allow only `s3:GetObject` on one bucket. |


**3. S3 (Simple Storage Service)**
🔹 What is S3?

S3 is object storage used for storing files, backups, logs, or artifacts.

Provides high availability (11 9’s) and supports versioning, lifecycle policies, and encryption.

🔹 Real-time Scenario:

Store application logs, Terraform state files, or Jenkins build artifacts in S3 with versioning enabled.

### 🔹 Common Interview Questions

| Question                       | Answer                                                                        |
| ------------------------------ | ----------------------------------------------------------------------------- |
| Difference between S3 and EBS? | S3 is object storage, EBS is block storage for EC2.                           |
| How to secure S3 bucket?       | Enable bucket policies, encryption (SSE-S3 / KMS), and disable public access. |
| What is S3 versioning?         | Keeps multiple versions of an object to recover accidental deletions.         |

**4. VPC (Virtual Private Cloud)**
🔹 What is VPC?

A virtual network that lets you define your IP range, subnets, route tables, and gateways.

Provides network isolation and control over traffic routing.

🔹 Real-time Scenario:

Deploy EKS or EC2 inside private subnets, connect to Internet via NAT Gateway, and use public subnets for load balancers.

### 🔹 Common Interview Questions

| Question                                      | Answer                                                                        |
| --------------------------------------------- | ----------------------------------------------------------------------------- |
| What components make up a VPC?                | Subnets, Route tables, Internet Gateway, NAT Gateway, Security Groups, NACLs. |
| Difference between SG and NACL?               | SG = stateful (instance level), NACL = stateless (subnet level).              |
| How do private instances access the Internet? | Through a NAT Gateway in a public subnet.                                     |

 
 
 **5. RDS (Relational Database Service)**
🔹 What is RDS?

Managed database service supporting MySQL, PostgreSQL, Oracle, etc.

AWS handles backups, patching, and replication.

🔹 Real-time Scenario:

Application in EKS connects to RDS via private endpoint. Automated backups are scheduled daily with encryption enabled.

### 🔹 Common Interview Questions

| Question                                  | Answer                                                                     |
| ----------------------------------------- | -------------------------------------------------------------------------- |
| How to secure RDS?                        | Place in private subnet, enable KMS encryption, restrict access using SGs. |
| Difference between Snapshot and Backup?   | Snapshot = manual, Backup = automated.                                     |
| How to do cross-region disaster recovery? | Copy snapshot to another region and restore there.                         |









| Feature   | **CloudWatch**                     | **CloudTrail**                |
| --------- | ---------------------------------- | ----------------------------- |
| Purpose   | Monitoring (metrics, logs, alarms) | Auditing (API activity)       |
| Data Type | Performance metrics                | API logs                      |
| Use Case  | CPU, memory, disk alerts           | Who deleted an EC2 instance   |
| Example   | Alert when EC2 CPU > 80%           | Track who modified IAM policy |
