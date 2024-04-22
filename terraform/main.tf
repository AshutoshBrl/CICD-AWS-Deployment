terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.46.0"
    }
  }
}


# provider "aws" {
#   access_key = "my-access-key"
#   secret_key = "my-secret-key"
#   region     = "us-east-1"
# }


resource "aws_security_group" "default-1" {
  name = "security group from terraform"

  ingress {
    description = "SSH from the internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "80 from the internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "8080 from the internet"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


resource "aws_instance" "aws_ins_web" {

  ami                         = "ami-080e1f13689e07408"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.default-1.id]
  associate_public_ip_address = true
  key_name                    = "ashutosh-webpoint" 
  user_data = <<-EOF
  #cloud-config

  package_update: true
  package_upgrade: true

  packages:
    - docker
    - docker-compose
    - curl
  runcmd:
    - apt install docker -y
    - apt install docker-compose-plugin -y
    - curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
    - chmod +x /usr/local/bin/docker-compose
    - apt install docker 
    - apt install docker-compose-plugin 
    - usermod -aG Docker ubuntu
    - systemctl start docker
    - systemctl enable docker

  final_message: "Docker and Docker Compose have been installed and enabled."
  EOF
  tags = {
    Name = "my-random-instance"
  }

}

output "instance_ip" {
  value = aws_instance.aws_ins_web.public_ip
}
