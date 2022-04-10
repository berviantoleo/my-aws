terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  cloud {
    organization = "bervproject"

    workspaces {
      name = "aws-personal-iac"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  alias  = "ap-southeast-1"
  region = "ap-southeast-1"
}

provider "aws" {
  alias  = "ap-southeast-3"
  region = "ap-southeast-3"
}

# ECR
resource "aws_ecr_repository" "demo_ecr" {
  provider = aws.ap-southeast-1

  name                 = "demo_ecr"
  image_tag_mutability = "MUTABLE"
  tags = {
    Environment = "dev"
  }
}

# Create a Dynamo DB
resource "aws_dynamodb_table" "ap-southeast-1" {
  provider = aws.ap-southeast-1

  hash_key         = "id"
  name             = "note"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  read_capacity    = 1
  write_capacity   = 1

  attribute {
    name = "id"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = true
  }

  tags = {
    Environment = "dev"
  }
}

resource "aws_dynamodb_global_table" "note" {
  depends_on = [
    aws_dynamodb_table.ap-southeast-1,
  ]
  provider = aws.ap-southeast-1

  name = "note"

  replica {
    region_name = "ap-southeast-1"
  }
}

resource "aws_default_vpc" "my-personal-web" {
  provider = aws.ap-southeast-1

  tags = {
    env = "dev"
  }
}

resource "aws_default_subnet" "my-personal-web" {
  provider          = aws.ap-southeast-1
  availability_zone = "ap-southeast-1a"

  tags = {
    env = "dev"
  }
}

resource "aws_default_subnet" "my-personal-web-1" {
  provider          = aws.ap-southeast-1
  availability_zone = "ap-southeast-1b"


  tags = {
    env = "dev"
  }
}

resource "aws_security_group" "my-personal-web" {
  provider = aws.ap-southeast-1

  name        = "allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_default_vpc.my-personal-web.id

  ingress {
    description = "Allow HTTP for all"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "my-personal-web" {
  provider = aws.ap-southeast-1

  name               = "my-personal-web-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.my-personal-web.id]
  subnets            = [aws_default_subnet.my-personal-web.id, aws_default_subnet.my-personal-web-1.id]
  tags = {
    env = "dev"
  }
}


resource "aws_lb_target_group" "my-personal-web" {
  provider = aws.ap-southeast-1

  name        = "tf-my-personal-web-lb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_default_vpc.my-personal-web.id
}

resource "aws_lb_listener" "my-personal-web" {
  provider = aws.ap-southeast-1

  load_balancer_arn = aws_lb.my-personal-web.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my-personal-web.arn
  }
}


resource "aws_ecs_cluster" "my-personal-web" {
  provider = aws.ap-southeast-1
  name     = "my-personal-web-api-cluster"
}

resource "aws_ecs_cluster_capacity_providers" "my-personal-web" {
  provider = aws.ap-southeast-1

  cluster_name = aws_ecs_cluster.my-personal-web.name

  capacity_providers = ["FARGATE"]
}

resource "aws_ecs_task_definition" "my-personal-web" {
  provider = aws.ap-southeast-1

  family                   = "service"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  container_definitions = jsonencode([
    {
      name      = "my-personal-web-api"
      image     = "nginx"
      cpu       = 1024
      memory    = 2048
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "my-personal-web" {
  provider = aws.ap-southeast-1

  name            = "my-personal-web"
  cluster         = aws_ecs_cluster.my-personal-web.id
  task_definition = aws_ecs_task_definition.my-personal-web.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_default_subnet.my-personal-web.id, aws_default_subnet.my-personal-web-1.id]
    security_groups  = [aws_security_group.my-personal-web.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.my-personal-web.arn
    container_name   = "my-personal-web-api"
    container_port   = 80
  }

  tags = {
    env = "dev"
  }

}