variable "cluster_name" {
    type = string
    description = "(optional) describe your variable"
}
variable "subnet_ids" {
    type = list(string)
    description = "(optional) describe your variable"
}
variable "node_subnets_ids" {
    type = list(string)
    description = "(optional) describe your variable"
}
variable "security_group_ids" {
    type = list(string)
    description = "(optional) describe your variable"
}
variable "endpoint_private_access" {
    type = bool
    description = "(optional) describe your variable"
}
variable "node_group_name" {
    type = string
    description = "(optional) describe your variable"
}
variable "ec2_ssh_key" {
    type = string
    description = "(optional) describe your variable"
}
variable "source_security_group_ids" {
    type = list(string)
    description = "(optional) describe your variable"
}
variable "instance_types" {
    type = list(string)
    description = "(optional) describe your variable"
}
variable "desired_size" {
    type = number
    description = "(optional) describe your variable"
}
variable "max_size" {
    type = number
    description = "(optional) describe your variable"
}
variable "min_size" {
    type = number
    description = "(optional) describe your variable"
}