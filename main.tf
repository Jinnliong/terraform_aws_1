provider "aws" {
  region = "ap-southeast-1" # Specify your desired AWS region
}

# Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "jinnliong-vpc"
  }
}

# Create Public, Private and DB Subnets and link them to respective availability zone
resource "aws_subnet" "public_subnet_1a" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "jinnliong-public-1a"
  }
}

resource "aws_subnet" "public_subnet_1b" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-southeast-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "jinnliong-public-1b"
  }
}

resource "aws_subnet" "public_subnet_1c" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "ap-southeast-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "jinnliong-public-1c"
  }
}

resource "aws_subnet" "private_subnet_1a" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "jinnliong-private-1a"
  }
}

resource "aws_subnet" "private_subnet_1b" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.5.0/24"
  availability_zone       = "ap-southeast-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "jinnliong-private-1b"
  }
}

resource "aws_subnet" "private_subnet_1c" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.6.0/24"
  availability_zone       = "ap-southeast-1c"
  map_public_ip_on_launch = false
  tags = {
    Name = "jinnliong-private-1c"
  }
}

resource "aws_subnet" "db_subnet_1a" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.7.0/24"
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "jinnliong-db-1a"
  }
}

resource "aws_subnet" "db_subnet_1b" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.8.0/24"
  availability_zone       = "ap-southeast-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "jinnliong-db-1b"
  }
}

resource "aws_subnet" "db_subnet_1c" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.9.0/24"
  availability_zone       = "ap-southeast-1c"
  map_public_ip_on_launch = false
  tags = {
    Name = "jinnliong-db-1c"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "jinnliong-igw"
  }
}

# Create NAT Gateway
resource "aws_eip" "my_eip" {
  # ... (Elastic IP configuration)
}

resource "aws_nat_gateway" "my_ngw" {
  allocation_id = aws_eip.my_eip.id
  subnet_id     = aws_subnet.private_subnet_1a.id

  tags = {
    Name = "jinnliong-ngw"
  }
}

# Create Public, Private and DB Route Tables
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "jinnliong-public-rt"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "jinnliong-private-rt"
  }
}

resource "aws_route_table" "db_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "jinnliong-db-rt"
  }
}

# Associate Private, Private and DB Subnets with their Respective Route Tables
resource "aws_route_table_association" "public_rt_association_1a" {
  subnet_id      = aws_subnet.public_subnet_1a.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_rt_association_1b" {
  subnet_id      = aws_subnet.public_subnet_1b.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_rt_association_1c" {
  subnet_id      = aws_subnet.public_subnet_1c.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_rt_association_1a" {
  subnet_id      = aws_subnet.private_subnet_1a.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_rt_association_1b" {
  subnet_id      = aws_subnet.private_subnet_1b.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_rt_association_1c" {
  subnet_id      = aws_subnet.private_subnet_1c.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "db_rt_association_1a" {
  subnet_id      = aws_subnet.db_subnet_1a.id
  route_table_id = aws_route_table.db_route_table.id
}

resource "aws_route_table_association" "db_rt_association_1b" {
  subnet_id      = aws_subnet.db_subnet_1b.id
  route_table_id = aws_route_table.db_route_table.id
}

resource "aws_route_table_association" "db_rt_association_1c" {
  subnet_id      = aws_subnet.db_subnet_1c.id
  route_table_id = aws_route_table.db_route_table.id
}

# Add Public, Private and DB Routes to their Respective Route Tables
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_igw.id
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.my_ngw.id
}

#resource "aws_route" "db_route" {
#  route_table_id         = aws_route_table.db_route_table.id
#  destination_cidr_block = aws_vpc.my_vpc.cidr_block
#  local_gateway_id       = aws_vpc.my_vpc.id
#}

# Create Security Group for EC2 instance using the generated VPC IP
resource "aws_security_group" "instance_sg" {
  description = "Security Group To Allow SSH from my IP range(s)"
  vpc_id      = aws_vpc.my_vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["202.166.159.65/32"] # Replace with your IP address or range
  }
  tags = {
    Name = "jinnliongSSHSecurityGroup"
  }
}

# Create EC2 instance
resource "aws_instance" "my_instance" {
  ami                    = "ami-02453f5468b897e31" # Replace with the actual Amazon Linux 2023 AMI ID
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet_1a.id
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  key_name               = "jl" # Replace with your SSH key pair name

  tags = {
    Name = "jinnliong-ec2"
  }
}