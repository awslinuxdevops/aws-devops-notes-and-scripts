# 🧱 Terraform Complete Guide (DevOps Real-Time + Interview Ready)

## 🗂️ 1. Introduction to Terraform

**Terraform** is an **Infrastructure as Code (IaC)** tool developed by **HashiCorp**.  
It allows you to **provision, manage, and automate infrastructure** across multiple providers (AWS, Azure, GCP, etc.) using **HCL (HashiCorp Configuration Language)**.

- **Declarative**: Define *what* you want, not *how* to do it.
- **Cross-Platform**: Works with multiple cloud providers.
- **Version Controlled**: Infrastructure managed like code.

---

## 🧩 2. Core Terraform Concepts

| Concept | Description | Example |
|----------|--------------|---------|
| **Provider** | Plugin to interact with cloud services | `provider "aws" { region = "us-east-1" }` |
| **Resource** | Basic building block (VM, S3, VPC, etc.) | `resource "aws_instance" "web" {...}` |
| **Variable** | Input values to make configuration dynamic | `variable "instance_type" { default = "t2.micro" }` |
| **Output** | Display values after apply | `output "instance_ip" { value = aws_instance.web.public_ip }` |
| **State** | Maintains infra info (`terraform.tfstate`) | Tracks current infrastructure |
| **Module** | Reusable set of Terraform configs | `module "vpc" { source = "./vpc" }` |
| **Data Source** | Fetch existing resource info | `data "aws_ami" "ubuntu" {...}` |
| **Backend** | Where Terraform state is stored | S3, GCS, Local, etc. |
| **Provisioner** | Run scripts post-creation | `remote-exec`, `local-exec` |

---

## ⚙️ 3. Terraform Workflow

1️⃣ **Write** → Define resources in `.tf` files  
2️⃣ **Initialize** → `terraform init`  
3️⃣ **Validate** → `terraform validate`  
4️⃣ **Plan** → `terraform plan`  
5️⃣ **Apply** → `terraform apply`  
6️⃣ **Destroy** → `terraform destroy`

---

## 🧾 4. Important Files

| File | Purpose |
|------|----------|
| **main.tf** | Main configuration |
| **variables.tf** | Variable declarations |
| **terraform.tfvars** | Variable values |
| **outputs.tf** | Output definitions |
| **provider.tf** | Provider configuration |
| **backend.tf** | Remote backend setup |
| **.terraform.lock.hcl** | Provider dependency lock |

---

## 🧮 5. Variables & Data Types

**Types:**  
`string`, `number`, `bool`, `list`, `map`, `set`, `object`, `tuple`

**Example:**
```
variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "tags" {
  type = map(string)
  default = {
    Name = "web"
    Env  = "dev"
  }
}
Usage in main.tf:

```
resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags          = var.tags
}
```


## 🪣 6. Providers
```
provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
```


## 🧱 7. Resources Example
```
resource "aws_instance" "myec2" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = var.instance_type

  tags = {
    Name = "TerraformEC2"
  }
}
```

## 🧮 8. Data Sources
```
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}


resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
}
```

## 🧰 9. Terraform Commands
| Command	 | Description |
|-----------|------------|
| terraform init	| Initialize working directory |
| terraform validate |	Validate syntax |
| terraform fmt	 | Format .tf files |
| terraform plan	| Preview execution plan |
| terraform apply	| Apply configuration |
| terraform destroy	 | Destroy infrastructure |
| terraform state list	| List tracked resources |
| terraform taint	 | Mark resource for recreation |
| terraform untaint	| Remove taint mark |
| terraform output	| Show output values |
| terraform import	| Import existing infra |
| terraform workspace	 | Manage environments |

## 🔁 10. Count & For_each

**count**

```
resource "aws_instance" "web" {
  count = 3
  ami   = var.ami_id
  instance_type = "t2.micro"
}

**for_each**


resource "aws_s3_bucket" "b" {
  for_each = toset(["dev", "test", "prod"])
  bucket   = "mybucket-${each.key}"
}
```

## 🧠 11. Conditionals
```
instance_type = var.env == "prod" ? "t3.medium" : "t2.micro"
```

## 🗃️ 12. State Management

##### Local state file: terraform.tfstate

**Remote Backend Example:**

```
terraform {
  backend "s3" {
    bucket         = "my-tf-state"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}
```

`🔒 Enables locking to prevent concurrent changes (via DynamoDB).`

## 🧱 13. Provisioners
```
resource "aws_instance" "web" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install nginx -y"
    ]
  }
}
```

## 🧩 14. Modules
**Folder Structure**

```
modules/
 └── vpc/
     ├── main.tf
     ├── variables.tf
     └── outputs.tf


module "vpc" {
  source      = "./modules/vpc"
  cidr_block  = "10.0.0.0/16"
}
```

## 🧭 15. Workspaces
**Manage multiple environments:**

```
terraform workspace new dev
terraform workspace list
terraform workspace select prod
Each workspace maintains its own state file.
```


## 🧠 16. Terraform Functions

| Function	| Description |
|-----------|-------------|
| length(list)	| Returns length of a list |
| join(",", list)	| Joins list with delimiter |
| file("file.txt")	| Reads file content |
| lookup(map, key, default)	| Fetch map value |
| upper(), lower()	| Case conversion |
| format()	| String formatting |

## 🔐 17. Security Best Practices
✅ Never hardcode credentials
✅ Use IAM Roles or environment variables
✅ Store state in S3 + lock in DynamoDB
✅ Ignore .tfstate files in .gitignore
✅ Encrypt state using KMS

## 🧑‍💻 18. Real-Time Scenarios

##### Scenario 1: Some EC2 instances failed to create

* Run terraform plan to debug

* Check dependencies (depends_on)

* Use terraform taint for recreation

* Verify IAM permissions

##### Scenario 2: Partial infra deployed

* Use terraform apply -target=resource.name

* Fix and re-run terraform apply

##### Scenario 3: Update tags for 100 EC2 instances
* Use for_each or count

* Always terraform plan before apply

## 🧑‍🏫 19. Common Interview Questions

Question	Answer
What is Terraform?	IaC tool to automate infra provisioning
Terraform vs CloudFormation?	Terraform = multi-cloud, CloudFormation = AWS-only
What is state file?	Tracks infra info & dependencies
How to handle sensitive data?	Use variables + environment vars + secret managers
Difference between count & for_each?	count = index-based, for_each = key-based
Terraform import use?	Bring existing infra under Terraform management
What is taint?	Marks a resource for recreation
What are provisioners?	Execute post-creation scripts
How to manage remote backend?	Store state in S3, lock with DynamoDB
Plan vs Apply?	Plan = Preview, Apply = Execute

## 🧱 20. Terraform in CI/CD (GitHub Actions Example)
**.github/workflows/terraform.yml**

```
name: Terraform CI/CD

on:
  push:
    branches:
      - main

jobs:
  terraform:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v3

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3

      - name: Terraform Init
        run: terraform init

      - name: Terraform Validate
        run: terraform validate

      - name: Terraform Plan
        run: terraform plan -out=tfplan

      - name: Terraform Apply
        run: terraform apply -auto-approve tfplan
```

