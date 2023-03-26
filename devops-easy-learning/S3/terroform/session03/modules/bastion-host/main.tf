# EC2 Instance
resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.ubuntu_20_04.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  subnet_id              = data.aws_subnet.default01.id
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-bastion-host", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])
    },
  )
}

# Create Elastic IP for Bastion Host
resource "aws_eip" "bastion_eip" {
  instance = aws_instance.bastion.id
  vpc      = true
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-bastion-host-eip", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])
    },
  )
}

