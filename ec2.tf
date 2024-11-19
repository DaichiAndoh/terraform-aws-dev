# ==================================
# ami
# ==================================
data "aws_ami" "ec2_ami" {
  most_recent = true
  owners      = ["self", "amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# ==================================
# key pair
# ==================================
resource "aws_key_pair" "ec2_key_pair" {
  key_name   = "${var.user}-${var.project}-ec2-key-pair"
  public_key = file("./ssh-key/ec2-keypair.pub")

  tags = {
    Name    = "${var.user}-${var.project}-ec2-key-pair"
    Project = var.project
    User    = var.user
  }
}

# ==================================
# ec2 instance
# ==================================
resource "aws_instance" "ec2" {
  ami                         = data.aws_ami.ec2_ami.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet_1a.id
  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id
  ]
  key_name = aws_key_pair.ec2_key_pair.key_name

  lifecycle {
    ignore_changes = [
      ami,
    ]
  }

  tags = {
    Name    = "${var.user}-${var.project}-ec2"
    Project = var.project
    User    = var.user
  }
}
