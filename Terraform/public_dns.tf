resource "aws_route53_zone" "primary" {
  name = "movieanalyst.tk"
}

#resource "aws_route53_record" "www" {
#  zone_id = aws_route53_zone.primary.zone_id
#  name    = "www"
#  type    = "A"
#
#  alias {
#    name                   = aws_lb.ecs_cluster.dns_name
#    zone_id                = aws_lb.ecs_cluster.zone_id
#    evaluate_target_health = true
#  }
#}

resource "aws_route53_record" "secure" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "secure"
  type    = "A"
  ttl     = 300
  records = [aws_instance.bastion.public_ip]
}
