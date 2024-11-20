module "network" {
  source = "../../modules/network"

  project = var.project
  user    = var.user
}

module "security_group" {
  source = "../../modules/security_group"

  project = var.project
  user    = var.user
  vpc_id  = module.network.vpc_id
}

module "ec2" {
  source = "../../modules/ec2"

  project             = var.project
  user                = var.user
  ec2_sg_id           = module.security_group.ec2_sg_id
  public_subnet_1a_id = module.network.public_subnet_1a_id
}

module "rds" {
  source = "../../modules/rds"

  project              = var.project
  user                 = var.user
  private_subnet_1a_id = module.network.private_subnet_1a_id
  private_subnet_1c_id = module.network.private_subnet_1c_id
  rds_sg_id            = module.security_group.rds_sg_id
  db_username          = var.db_username
  db_password          = var.db_password
  db_name              = var.db_name
}
