output "instance_ip" {
  value = aws_instance.demo_ec2.public_ip
}