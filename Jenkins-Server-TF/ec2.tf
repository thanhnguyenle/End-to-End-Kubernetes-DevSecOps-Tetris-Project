# resource "aws_instance" "ec2" {
#   ami                    = data.aws_ami.ami.image_id
#   instance_type          = "t3a.2xlarge"
#   key_name               = var.key-name
#   subnet_id              = aws_subnet.public-subnet.id
#   vpc_security_group_ids = [aws_security_group.security-group.id]
#   iam_instance_profile   = aws_iam_instance_profile.instance-profile.name
#   root_block_device {
#     volume_size = 30
#   }
#   user_data = templatefile("./tools-install.sh", {})

#   tags = {
#     Name = var.instance-name
#   }
# }

resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.ami.image_id
  instance_type          = "t3a.medium"  # Changed from t3a.2xlarge
  key_name               = var.key-name
  subnet_id              = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.security-group.id]
  iam_instance_profile   = aws_iam_instance_profile.instance-profile.name
  
  # --- SPOT INSTANCE CONFIGURATION ---
  instance_market_options {
    market_type = "spot"
    spot_options {
      max_price = "0.03" # Optional: Max price you're willing to pay per hour
      spot_instance_type = "one-time" # Can be "one-time" or "persistent"
    }
  }
  # -----------------------------------

  root_block_device {
    volume_size = 30
    delete_on_termination = true # Good for study/testing
  }

  user_data = templatefile("./tools-install.sh", {})

  tags = {
    Name = var.instance-name
  }
}

# resource "tls_private_key" "ec2_key" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "aws_key_pair" "ec2_key" {
#   key_name   = var.key-name
#   public_key = tls_private_key.ec2_key.public_key_openssh
# }

# # Save the private key locally (be careful with this!)
# resource "local_file" "private_key" {
#   content  = tls_private_key.ec2_key.private_key_pem
#   filename = "${path.module}/my-ec2-key.pem"
#   file_permission = "0400"
# }
