#  Terraform scripts: 

```
# simple script:
provider "aws" {
    region = "ap-south-1"
}

resouce "ec2_instance" "devopsec2" {
    ami = ""
    instance_type = "t2.micro"


    tags = {
        Name = "devopsec2"
    }
}
```
```
# incremental script:
resource "aws_instance" "example" {
  count = 10
  ami           = "ami-0c94855ba95c71c99"
  instance_type = "t2.micro"

  tags = {
    Name = "Instance-$(count.index)"
  }
}
```
### Scenario_1:
- In terraform, if you already have 5 EC2 instance running and want to add 5 more EC2 instances to the same existing state  without disturbing the already-running instance, you can follow these steps:

1.  Current Configuration with 5 EC2 Instances:
```
provider "aws" {
    region = "ap-south-1"
}

# Define existing EC2 instance (already running 5 instances)
resource "aws_instance" "existing_instances" {
    count = 5
    ami           = "ami-0c94855ba95c71c99"
    instance_type = "t2.micro"

    tags = {
        Name = "Instance-$(count.index)"
    }
}

output "existing_instance_ids" {
    value = aws_instance.existing_instances.*.id
}
```
2. Modify Configuration to 'ADD 5 More EC2' instances:
```
# Update to add more EC2 instances (already running 5 instances)
resource "aws_instance" "existing_instances_ec2" {
    count = 10                        # Increase count from 5 to 10
    ami           = "ami-0c94855ba95c71c99"
    instance_type = "t2.micro"

    tags = {
        Name = "Instance-$(count.index)"
    }
}

output "existing_instance_ids" {
    value = aws_instance.existing_instances_ec2.*.id
}
```

### Scenario_2:
- To create an EC2 instance and attach the root directory of an s3 bucket using terraform, you'll need to write
  a script that: 
  * Create an EC2 instance
  * Create an S3 bucket
  * Configure the EC2 instance to access the s3 bucket ( IAM  roles or an instance profile to grant access)







```
