resource "aws_security_group" "example-instance" {
  vpc_id = "${aws_vpc.main.id}"
  name = "Example-Instance"
  description = "security group that allows ssh and all egress traffic"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

 } 
tags {
    Name = "example-instance"
  }
}

resource "aws_security_group" "allow-sqldb" {
  vpc_id = "${aws_vpc.main.id}"
  name = "allow-sqldb"
  description = "allow-sqldb"
  ingress {
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      security_groups = ["${aws_security_group.example-instance.id}"]              # allowing access from our example instance
  }
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      self = true
  }
  tags {
    Name = "allow-sqldb"
  }
}

