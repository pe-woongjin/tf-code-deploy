output "id" {
  value = data.aws_vpc.prd-aip.id
}

output "prd-aip-mgmt-sg" {
  value = data.aws_security_group.prd-aip-mgmt-sg
}

output "prd-aip-redpipe-sender-sg" {
  value = data.aws_security_group.prd-aip-redpipe-sender-sg
}
