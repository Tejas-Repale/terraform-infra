output "app_server_private_ip" {
  value = aws_instance.app_server.private_ip
}

output "web_server_public_ip" {
  value = aws_instance.web.public_ip
}
