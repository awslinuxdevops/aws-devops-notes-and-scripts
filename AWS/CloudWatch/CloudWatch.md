# ☁️ AWS CloudWatch 

## 📘 What is Cloudwatch

**Amazon CloudWatch** is a monitoring and observability service used to track AWS resources, custom applications, and infrastructure in real-time.  
It helps DevOps engineers collect **metrics, logs, and events**, providing visibility into **performance, resource utilization, and system health.**

---

## 🚀 Core Components

| Component | Description | Real-Time Use Case |
|------------|--------------|--------------------|
| **Metrics** | Numeric data about resource performance (CPU, Memory, Network) | Monitor EC2 CPU usage or EBS IOPS |
| **Alarms** | Trigger notifications or actions when thresholds are crossed | Alert if CPU > 80% |
| **Logs** | Collect, monitor, and analyze logs | View app logs from EC2, ECS, or Lambda |
| **Events (EventBridge)** | Detect and respond to resource state changes | Auto-trigger Lambda when EC2 stops |
| **Dashboards** | Visualize metrics and logs in one place | Unified view for EC2, RDS, EKS |
| **Insights** | Query-based log analytics | Find “ERROR” in ECS/Lambda logs |

---

## 📊 Metrics

### Default Metrics
- Provided automatically by AWS services (EC2, RDS, Lambda, etc.)

**Examples:**
| Service | Metric Examples |
|----------|-----------------|
| EC2 | `CPUUtilization`, `NetworkIn`, `DiskReadOps` |
| RDS | `DatabaseConnections`, `FreeStorageSpace` |
| ELB | `RequestCount`, `Latency`, `HTTPCode_ELB_5XX` |
| Lambda | `Invocations`, `Errors`, `Duration` |

### Custom Metrics
Push your own app or on-prem metrics using the AWS CLI or SDK.

```
aws cloudwatch put-metric-data \
  --namespace "CustomApp" \
  --metric-name "RequestCount" \
  --value 150
```
```
aws cloudwatch list-metrics --namespace AWS/EC2
```

#### Example: Trigger SNS if EC2 CPU > 80% for 5 mins
```
aws cloudwatch put-metric-alarm \
  --alarm-name "HighCPU" \
  --metric-name CPUUtilization \
  --namespace AWS/EC2 \
  --statistic Average \
  --period 300 \
  --threshold 80 \
  --comparison-operator GreaterThanThreshold \
  --dimensions Name=InstanceId,Value=i-0123456789abcdef0 \
  --evaluation-periods 1 \
  --alarm-actions arn:aws:sns:us-east-1:123456789012:NotifyMe

```

### CloudWatch vs CloudTrail

| Feature          | **CloudWatch**                          | **CloudTrail**                          |
| ---------------- | --------------------------------------- | --------------------------------------- |
| **Purpose**      | Performance monitoring                  | Auditing and API tracking               |
| **Data Type**    | Metrics, logs, events                   | API calls (who, what, when, where)      |
| **Use Case**     | Operational monitoring                  | Security, compliance, investigation     |
| **Example Data** | `CPUUtilization`, `DiskUsage`, app logs | `RunInstances`, `DeleteBucket`          |
| **Source**       | AWS services, applications              | AWS Console, SDK, CLI                   |
| **Actions**      | Alarms, SNS, Lambda, Auto Scaling       | Audit logs to S3, CloudWatch Logs       |
| **Retention**    | Customizable                            | 90 days (default), can deliver to S3    |
| **View**         | Real-time                               | Historical                              |
| **Example**      | Detect EC2 high CPU                     | Find who terminated an instance         |
| **Integration**  | Works with metrics and dashboards       | Works with S3, EventBridge, and CW Logs |
