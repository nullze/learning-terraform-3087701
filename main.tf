data "aws_ami" "app_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["bitnami-odoo-16.0.20230615-2-r04-linux-debian-11-x86_64-hvm-ebs-nami"] # Latest version of Bitnami's ODOO instance. https://bitnami.com/stack/odoo/cloud/aws/amis
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["979382823631"] # Bitnami
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.app_ami.id
  instance_type = "t3.nano"

  tags = {
    Name = "Odoo Software - Test"
  }
}

# Terraform is a DevOps tool for declerative infrastructure - infrastructure
# as code. It simplifis and accelerates the configuration of cloud-based environments.

# Terraform figures out the hard part of resource ordering and lets
# you just treat the infrastructure as static code.

# Terraform plan is powerful, and compares the state of the current
# infrastructure to what exists and gives you a step by step review
# of what's going to be changed.

# Terraform knows how to do things by using a data structure known as a graph. 
# More specifically, it uses a graph called a Directed Acyclic Graph. 

# A graph is made of a series of connected dots, and with Terraform,
# like an S3 bucket, a domain name, and an EC2 instance, it goes acyclic,
# one way, towards the end. 

# How does Terraform keep track of what is going on in the infrastructure?

# Terraform is aware of the STATE of our AWS infrastructure. Terraform keeps
# a state file to track that. You can see that in the Cloud UI by clicking on STATES. 

# If you trigger another run, you can compare the difference in STATE files. 
# STATE files are incredibly helpful when troubleshooting when something breaks. 


