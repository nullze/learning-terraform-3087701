output "instance_ami" {
  value = aws_instance.blog.ami #Changing from "web" to "blog" to match main.tf file
}

output "instance_arn" {
  value = aws_instance.blog.arn # Changing from "web" to "blog" to match main.tf file
}
