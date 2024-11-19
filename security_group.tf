# ==================================
# security group for ec2
# ==================================
resource "aws_security_group" "ec2_sg" {
  name        = "${var.user}-${var.project}-ec2-sg"
  description = "This is a security group for ec2."
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name    = "${var.user}-${var.project}-ec2-sg"
    Project = var.project
    User    = var.user
  }
}

resource "aws_security_group_rule" "ec2_sg_in_ssh" {
  security_group_id = aws_security_group.ec2_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ec2_sg_in_http" {
  security_group_id = aws_security_group.ec2_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ec2_sg_in_https" {
  security_group_id = aws_security_group.ec2_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ec2_sg_out" {
  security_group_id = aws_security_group.ec2_sg.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

# ==================================
# security group for rds
# ==================================
resource "aws_security_group" "rds_sg" {
  name        = "${var.user}-${var.project}-rds-sg"
  description = "This is a security group for rds."
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name    = "${var.user}-${var.project}-rds-sg"
    Project = var.project
    User    = var.user
  }
}

resource "aws_security_group_rule" "rds_sg_in_mysql_from_ec2_sg" {
  security_group_id        = aws_security_group.rds_sg.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
  source_security_group_id = aws_security_group.ec2_sg.id
}
