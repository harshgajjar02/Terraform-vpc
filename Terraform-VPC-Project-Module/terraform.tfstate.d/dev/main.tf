module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "network-demo-vpc"
  cidr = "10.19.0.0/16"
  azs  = ["us-east-1a", "us-east-1b", "us-east-1c"]
  # sn-web 
  public_subnets = ["10.19.0.0/20", "10.19.64.0/20", "10.19.128.0/20"]
  # 
  private_subnets = ["10.19.16.0/20", "10.19.80.0/20", "10.19.144.0/20",
    "10.19.32.0/20", "10.19.96.0/20", "10.19.160.0/20",
  "10.19.48.0/20", "10.19.112.0/20", "10.19.176.0/20"]

  enable_nat_gateway      = true
  single_nat_gateway      = true
  one_nat_gateway_per_az  = false
  enable_dns_hostnames    = true
  enable_dns_support      = true
  map_public_ip_on_launch = true
  instance_tenancy        = "default"

  public_subnet_names = ["sn-web-A", "sn-web-B", "sn-web-C"]

  private_subnet_names = ["sn-app-A", "sn-app-B", "sn-app-C", "sn-db-A", "sn-db-B", "sn-db-C", "sn-reserved-A", "sn-reserved-B", "sn-reserved-C"]

  tags = {
    Name        = "network-demo-vpc"
    Environment = "dev"
  }
}

output "subnet-id" {
  value = slice(module.vpc.public_subnets, 0, 1)[0]
}

output "vpc-id" {
  value = module.vpc.vpc_id
}

resource "aws_security_group" "webSg" {
  name   = "web"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web-sg"
  }
}

resource "aws_instance" "server" {
  ami                    = "ami-0261755bbcb8c4a84"
  instance_type          = "t2.micro"
  key_name               = "key-name"
  vpc_security_group_ids = [aws_security_group.webSg.id]
  subnet_id              = slice(module.vpc.public_subnets, 0, 1)[0]

  connection {
    type        = "ssh"
    user        = "ubuntu"              # Replace with the appropriate username for your EC2 instance
    private_key = file("<key path>") # Replace with the path to your private key
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remote instance'",
      "sudo apt update -y",                  # Update package lists (for ubuntu)
      "sudo apt install nginx -y", # Example package installation
    ]
  }
}
