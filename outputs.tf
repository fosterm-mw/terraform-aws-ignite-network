
output "network_id" {
  value = aws_vpc.network.id
}

output "private_subnet_id" {
  value = aws_subnet.private-subnet.id
}

output "failover_private_subnet_id" {
  value = aws_subnet.private-failover-subnet.id
}

