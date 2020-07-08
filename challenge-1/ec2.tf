resource "aws_autoscaling_group" "frontend" {
  name                 = "frontend-servers"
  max_size             = 2
  min_size             = 1
  desired_capacity     = 1
  force_delete         = true
  vpc_zone_identifier  = aws_subnet.public.*.id
  launch_configuration = "${aws_launch_configuration.web_servers.name}"
}

resource "aws_autoscaling_group" "backend" {
  name                 = "backend-servers"
  max_size             = 2
  min_size             = 1
  desired_capacity     = 1
  force_delete         = true
  vpc_zone_identifier  = aws_subnet.private.*.id
  launch_configuration = "${aws_launch_configuration.web_servers.name}"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_launch_configuration" "web_servers" {
  name          = "web_app"
  image_id      = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
}
