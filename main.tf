# Mumbai EC2 - Amazon Linux 2
resource "aws_instance" "mumbai_ec2" {
  ami                    = "ami-0ff5003538b60d5ec"
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.sg_mumbai.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install nginx1 -y
              systemctl start nginx
              systemctl enable nginx
              EOF

  tags = {
    Name = "Mumbai-Nginx-Server"
  }
}

# Virginia EC2 - Ubuntu 22.04
resource "aws_instance" "virginia_ec2" {
  provider               = aws.us
  ami                    = "ami-0b6c6ebed2801a5cb"
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.sg_virginia.id]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install nginx -y
              systemctl start nginx
              systemctl enable nginx
              EOF

  tags = {
    Name = "Virginia-Nginx-Server"
  }
}
