data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "jenkins" {
  key_name   = "${var.project_name}-jenkins-key"
  public_key = var.jenkins_public_key

  tags = {
    Name        = "${var.project_name}-jenkins-key"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_instance" "jenkins" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = var.jenkins_subnet_id
  vpc_security_group_ids = [var.jenkins_sg_id]
  key_name               = aws_key_pair.jenkins.key_name

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
    encrypted   = true
  }

  user_data = <<-EOF
    #!/bin/bash
    # Update system
    yum update -y

    # Install git and docker
    yum install -y git docker

    # Start and enable Docker
    systemctl start docker
    systemctl enable docker
    usermod -aG docker ec2-user

    # Install Jenkins
    wget -O /etc/yum.repos.d/jenkins.repo \
      https://pkg.jenkins.io/redhat-stable/jenkins.repo
    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    yum install -y java-17-amazon-corretto jenkins
    systemctl start jenkins
    systemctl enable jenkins

    # Install AWS CLI v2
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    ./aws/install

    # Install kubectl
    curl -LO "https://dl.k8s.io/release/$(curl -L -s \
      https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl
    mv kubectl /usr/local/bin/

    # Install Helm
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

    # Add jenkins user to docker group
    usermod -aG docker jenkins
  EOF

  depends_on = [aws_key_pair.jenkins]

  tags = {
    Name        = "${var.project_name}-jenkins"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
