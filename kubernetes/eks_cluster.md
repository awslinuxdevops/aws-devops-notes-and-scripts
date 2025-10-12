# Step-by-step Guide to Upgrade EKS Cluster Version from 1.28 to 1.20

### Step 1: Backup your current Terraform state
- Before making any changes, it's a good practice to backup your current Terraform state. This will
ensure that you can easily revert back to your previous state if something goes wrong.
```
cp terraform.tfstate terraform.tfstate.backup
```

### Step 2: Update the EKS Cluster Version in the Terraform Configuration
- Update the `eks_cluster_version` variable in your Terraform configuration to the desired version
(1.28 to 1.29)
```
resource "aws_eks_cluster" "example" {
    name     = "example"
    role_arn = aws_iam_role.example.arn
    version  = "1.29" # Update the version here

    vpc_config {
        security_group_ids = [aws_security_group.example.id]
    }

    # Other configurations like node groups, security groups, etc
}
```

### Step 3: Upgrade Node Groups (if applicable)
```
resource "aws_eks_node_group" "example" {
    cluster_name    = aws_eks_cluster.example.name
    node_group_name = "example"
    node_role_arn   = aws_iam_role.example.arn
    subnets_ids =  aws_subnet.subnet.*.id
    version =   "1.29"  # update the version from 1.28 to 1.29

    scaling_config {
        desired_size = 2
        max_size     = 5
        min_size     = 2
    }

    # AMI Version ( optional)
    ami_type = "AL2_x86_64"

}
```
### Step 4: Terraform commands:
```
terraform plan
terraform apply
```

### Step 5: Monitor the upgrade process
```
# cluster status

aws eks describe-cluster --name my-cluster --query "cluster.version"

# node status
aws eks describe-nodegroup --cluster-name my-cluster --nodegroup-name my-nodegroup --query "
```


