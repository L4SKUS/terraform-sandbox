resource "tls_private_key" "default" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "default" {
  key_name   = "test-key-pair"
  public_key = tls_private_key.default.public_key_openssh
}

resource "aws_instance" "test" {
  ami                  = "ami-0a5b0d219e493191b"
  instance_type        = "t2.micro"
  key_name             = aws_key_pair.default.key_name
  subnet_id            = element(module.vpc.private_subnets, 0)
  iam_instance_profile = aws_iam_instance_profile.test_profile.name

  vpc_security_group_ids = [aws_security_group.test_sg.id]

  tags = {
    Name = "test-ec2"
  }
}

#####################
# IAM EC2 RESOURCES #
#####################
resource "aws_iam_role" "test_role" {
  name = "ec2-assume-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_instance_profile" "test_profile" {
  role = aws_iam_role.test_role.name
}

resource "aws_iam_role_policy_attachment" "test_role_attach_AmazonSSMManagedInstanceCore" {
  role       = aws_iam_role.test_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}


###################
# SECURITY GROUPS #
###################
resource "aws_security_group" "test_sg" {
  vpc_id      = module.vpc.vpc_id
  description = "Test security group"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

