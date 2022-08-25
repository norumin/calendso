resource "aws_db_instance" "db" {
  identifier                = "dbi-${local.slug}"
  instance_class            = var.db_instance_class
  engine                    = var.db_engine
  engine_version            = var.db_engine_version
  parameter_group_name      = aws_db_parameter_group.default.name
  allocated_storage         = var.db_allocated_storage
  max_allocated_storage     = var.db_max_allocated_storage
  username                  = var.db_username
  password                  = var.db_password
  db_name                   = var.db_name
  db_subnet_group_name      = aws_db_subnet_group.root.name
  vpc_security_group_ids    = var.sg_ids
  publicly_accessible       = var.db_publicly_accessible
  final_snapshot_identifier = "dbsnap-${local.slug}-final"
  copy_tags_to_snapshot     = true
  deletion_protection       = "production" == var.stage

  tags = merge(local.default_tags, {
    Name = "dbi-${local.slug}"
  })
}

resource "aws_db_subnet_group" "root" {
  name        = "dbsng-${local.slug}"
  description = "DB subnet group inside the main VPC"
  subnet_ids  = var.db_publicly_accessible ? var.public_subnet_ids : var.private_subnet_ids

  tags = merge(local.default_tags, {
    Name = "dbsng-${local.slug}"
  })
}

resource "aws_db_parameter_group" "default" {
  name        = "dbpg-${local.slug}"
  description = "Default DB parameter group"
  family      = "${var.db_engine}${join(".", slice(split(".", var.db_engine_version), 0, 1))}"

  tags = merge(local.default_tags, {
    Name = "dbpg-${local.slug}"
  })
}
