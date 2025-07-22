provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "demo_ec2" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  key_name      = "your-key-name"

  tags = {
    Name = "demo-instance"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y docker.io",
      "sudo systemctl start docker",
      "sudo docker run -d -p 8080:8080 aravind/demoapp:latest"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/your-key.pem")
      host        = self.public_ip
    }
  }
}