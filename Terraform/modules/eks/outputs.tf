output "cluster_endpoint" {
  value = aws_eks_cluster.aws_eks.endpoint
}

output "cluster_certificate_authority" {
  value = aws_eks_cluster.aws_eks.certificate_authority[0].data
}

output "cluster_id" {
  value = aws_eks_cluster.aws_eks.id
}