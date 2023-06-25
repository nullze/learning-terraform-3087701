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

# Terraform is very detailed when describing the errors it finds with its files. 

# Resources

# Now is time to take a deeper dive into Terraform code. 

# A provider isn't a resource, but it sets a provder for a set of possible resources to define. 
# You need to have a provider in your code, so that Terraform knows where the resources should go. 
# The resource defined in the example is an AWS S3 Bucket, which is pretty simple. 
# The word "resource" tells Terraform that a resource is going to be created, next is the resource type "aws_s3_bucket" for example. 
# Next, is the resource name "tf-course" which can be whatever you want to name your resource. 

#resource "aws_s3_bucket" "tf-course" {
  #bucket = "samuelson-terraform-20220826"
  #acl = "private"
#}

# In Terraform, the name tf-course is easier to use, where-as in AWS, a unique name may have to include a date string to make sure bucket names are all unique. 
# The ACL = "private" means that the bucket will be private. 
# This is a simple example, and Terraform can add a lot of other variables to the resources.