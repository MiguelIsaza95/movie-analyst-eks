resource "aws_security_group_rule" "bastion_rds" {
  type                     = "egress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.bastion_sg.id
  source_security_group_id = aws_security_group.db_sg.id
  description              = "Allow mysql traffic from bastion to mysql server"
}

resource "aws_security_group_rule" "cluster_ingress" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.cluster_sg.id
  source_security_group_id = aws_security_group.cluster_sg.id
}

resource "aws_security_group_rule" "cluster_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.cluster_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}