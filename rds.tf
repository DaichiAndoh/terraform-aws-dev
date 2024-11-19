# ==================================
# rds parameter group
# ==================================
resource "aws_db_parameter_group" "rds_param_gr" {
  name   = "${var.user}-${var.project}-rds-param-gr"
  family = "mysql8.0"

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }
  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }
  parameter {
    name = "time_zone"
    value = "Asia/Tokyo"
  }
}

# ==================================
# rds option group
# ==================================
resource "aws_db_option_group" "rds_opt_gr" {
  name                 = "${var.user}-${var.project}-rds-opt-gr"
  engine_name          = "mysql"
  major_engine_version = "8.0"
}

# ==================================
# rds subnet group
# ==================================
resource "aws_db_subnet_group" "rds_subnet_gr" {
  name = "${var.user}-${var.project}-rds-subnet-gr"
  subnet_ids = [
    aws_subnet.private_subnet_1a.id,
    aws_subnet.private_subnet_1c.id,
  ]

  tags = {
    Name    = "${var.user}-${var.project}-rds-subnet-gr"
    Project = var.project
    User    = var.user
  }
}

# ==================================
# rds instance
# ==================================
resource "aws_db_instance" "rds_instance" {
  identifier = "${var.user}-${var.project}-rds-instance"

  # database
  instance_class       = "db.t3.micro"
  engine               = "mysql"
  engine_version       = "8.0"
  parameter_group_name = aws_db_parameter_group.rds_param_gr.name
  option_group_name    = aws_db_option_group.rds_opt_gr.name
  username             = var.db_username
  password             = var.db_password
  db_name              = var.db_name

  # storage
  allocated_storage     = 20
  max_allocated_storage = 20
  storage_type          = "gp2"
  storage_encrypted     = false

  # network
  multi_az               = false
  availability_zone      = "ap-northeast-1a"
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_gr.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  publicly_accessible    = false
  port                   = 3306

  # deletion config
  deletion_protection = false
  skip_final_snapshot = true

  apply_immediately = true

  tags = {
    Name    = "${var.user}-${var.project}-rds-instance"
    Project = var.project
    User    = var.user
  }
}
