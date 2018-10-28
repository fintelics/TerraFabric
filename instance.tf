provider "aws" {
  access_key = "AKIAILQKATOSRQDG43SA"
  secret_key = "ZQ7tF2PR6bf0qXjX/NclgPOeubGf/q0OEJGRwGY1"
  region     = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
provisioner "local-exec" {                                              
           command = "echo ${aws_instance.example.private_ip} >> private_ips.txt"
}
}
output "ip"{
value="${aws_instance.example.public_ip}"
}
