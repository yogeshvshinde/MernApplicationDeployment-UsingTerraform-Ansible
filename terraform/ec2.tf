data "aws_ami" "al2023" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_instance" "web" {
  ami = data.aws_ami.al2023.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  iam_instance_profile = aws_iam_instance_profile.profile.name
  key_name = var.key_name
  tags = { Name = "web-server" }
}

resource "aws_instance" "db" {
  ami = data.aws_ami.al2023.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  iam_instance_profile = aws_iam_instance_profile.profile.name
  key_name = var.key_name
  tags = { Name = "db-server" }
}
