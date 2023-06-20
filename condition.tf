variable "server_name" {
  type    = list(string)
  default = ["myvm1", "myvm2", "myvm3"]
}

variable "booleantype" {
  type    = bool
  default = true
}

variable "instancetype" {
  type    = bool
  default = true
}

data "aws_ami" "amimumbai" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.amimumbai.id
  instance_type = var.instancetype == true ? "t2.medium" : "t2.micro"
  count         = var.booleantype == true ? 3 : 0
  tags = {
    Name = upper("${var.server_name[count.index]}")
  }
}
