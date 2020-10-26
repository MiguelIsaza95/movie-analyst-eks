resource "aws_instance" "bastion" {
  depends_on                  = [aws_route53_record.db]
  monitoring                  = true
  ami                         = data.aws_ami.ubuntu_18_latest.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  security_groups             = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true
  subnet_id                   = element(aws_subnet.dmz_public.*.id, 0)
  user_data                   = filebase64("${path.module}/bastion.sh")
  tags = {
    Name        = "bastion"
    Environment = "Test"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "nat" {
  monitoring                  = true
  ami                         = data.aws_ami.nat_latest.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  security_groups             = [aws_security_group.nat_sg.id]
  associate_public_ip_address = true
  subnet_id                   = element(aws_subnet.dmz_public.*.id, 1)
  tags = {
    Name        = "nat"
    Environment = "Test"
  }
  lifecycle {
    create_before_destroy = true
  }
  source_dest_check = false
}

resource "aws_launch_template" "cluster_conf" {
  monitoring {
    enabled = true
  }
  name_prefix            = "cluster_server_config"
  image_id               = data.aws_ami.eks_latest.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.cluster_nodes_sg.id]
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "movie_cluster"
      Environment = "Test"
    }
  }
  lifecycle {
    create_before_destroy = false
  }
}

resource "aws_db_instance" "mysql_server" {
  engine                = var.engine
  engine_version        = var.engine_version
  identifier            = "moviedb"
  username              = var.db_username
  password              = var.db_password
  instance_class        = var.db_instance_type
  allocated_storage     = 20
  max_allocated_storage = 100
  multi_az              = false
  publicly_accessible   = false
  port                  = 3306
  tags = {
    Name        = "Mysql_Server"
    Environment = "Test"
  }
  vpc_security_group_ids = [aws_security_group.db_sg.id, aws_security_group.general_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.default.id

  parameter_group_name = aws_db_parameter_group.default.id
  skip_final_snapshot  = true
}

resource "aws_db_snapshot" "db_snapshot" {
  db_instance_identifier = aws_db_instance.mysql_server.id
  db_snapshot_identifier = "moviesnapshot1234"
}

resource "aws_db_parameter_group" "default" {
  name   = "mysql-pg"
  family = "mysql8.0"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = aws_subnet.clusterprivate.*.id
}