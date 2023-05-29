resource "aws_instance" "terraform-ec2" {
  ami               = "ami-0715c1897453cabd1"
  availability_zone = "us-east-1a"
  instance_type     = "t2.micro"

  tags = {
    Name = "my-ec2"
  }
}

resource "aws_ebs_volume" "terraform-ebs" {
  availability_zone = "us-east-1a"
  size              = 10

  depends_on = [ 
    aws_instance.terraform-ec2
   ]
}

resource "aws_volume_attachment" "terraform-ebs-att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.terraform-ebs.id
  instance_id = aws_instance.terraform-ec2.id
  depends_on = [ 
    aws_ebs_volume.terraform-ebs
   ]
}


