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

resource "aws_instance" "blog" { #Changing "web" to "blog" to see how Terraform reacts to errors.
  ami           = data.aws_ami.app_ami.id
  instance_type = var.instance_type #Changing this to var.instance_type to use the variables set in variables.tf

  tags = {
    Name = "Bitnami ODOO Software 16.0.20230615-R04 - Test 2.0"
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

# Now we begin testing what happens when you change code in Terraform. 
# Uncommented all in the variables.tf file. Also uncommenting outputs.tf 

#If you are not seeing the results of your current run, it may be behind a previous run that
# was not applied. Since Terraform is acyclic, you have to keep track of runs in sequential order.

# How does Terraform react to errors? Change the "web" field under AWS instance to "blog" and see what happens.