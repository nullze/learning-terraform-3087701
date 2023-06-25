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

  owners   = ["979382823631"] # Bitnami
}

data "aws_vpc" "default" { # Set up a Default AWS VPC.
  default  = true
}

resource "aws_instance" "blog" { #Changing "web" to "blog" to see how Terraform reacts to errors.
  ami           = data.aws_ami.app_ami.id
  instance_type = var.instance_type #Changing this to var.instance_type to use the variables set in variables.tf

  vpc_security_group_ids = [aws_security_group.blog.id] # This is a VPC Security Group that was setup below. This adds the below parameters setup in the security group to allow ports 443 and 80 ingress, and everything egress. 

  tags = {
    Name = "Bitnami ODOO Software 16.0.20230615-R04 - Test 2.0"
  }
}

resource "aws_security_group" "blog" { # Creating an AWS_SECURITY_GROUP (think of it as a singular firewall for an instance) that has the name "blog" and description.
  name        = "blog"
  description = "Allow http and https web traffic in, allow everything out."

  vpc_id = data.aws_vpc.default.id #Referencing the Default AWS VPC that is above.
}

resource "aws_security_group_rule" "blog_http_in" { # This is creating an AWS Security Group rule called "Blog_HTTP_IN" that is type ingress (traffic coming in) from port 80 to port 80 (our blog) from any cidr block. (Public)
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.blog.id # This assigns the new rule to our AWS Security Group, blog. 
}

resource "aws_security_group_rule" "blog_https_in" { # This is creating an AWS Security Group rule called "Blog_HTTPS_IN" that is type ingress (traffic coming in) from port 443 to port 443 (our blog) from any cidr block. (Public)
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.blog.id # This assigns the new rule to our AWS Security Group, blog. 
}

resource "aws_security_group_rule" "blog_everything_out" { # This is creating an AWS Security Group rule called "Blog_Everything_Out" that is type egress (traffic going out) from port 0 to port 0 (our blog) from any cidr block. (Public)
  type        = "egress"
  from_port   = 0 #Setting up zero allows all ports.
  to_port     = 0 #Setting up zero allows all ports.
  protocol    = "-1" #Negative one allows all protocols out.
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.blog.id # This assigns the new rule to our AWS Security Group, blog. 
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

# INDENTATION

# The proper indentation for a Terraform file is 2 spaces rather than a tab.
# Keep blank lines for clarity, especially after Single Meta-Arguments and Block Meta-Arguments. 
# Always think about readability when setting up your code. 
# Good practive to have all equal signs aligned. 

# Think of AWS Security Groups as Firewalls that can be configured for a Single Instance. 

# Time to develop a VPC. 