###########################################
# Provider Configuration
###########################################
provider "aws" {
  region = "us-east-1"
}

###########################################
# ECS Cluster
###########################################
resource "aws_ecs_cluster" "main" {
  name = "devops-ecommerce-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Project = "DevOps-Ecommerce"
    Owner   = "Vignesh"
  }
}

###########################################
# IAM Role for ECS Task Execution
###########################################
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

###########################################
# ECS Task Definition
###########################################
resource "aws_ecs_task_definition" "app_task" {
  family                   = "app-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  # Uses your JSON file
  container_definitions = file("${path.module}/ecs-task-def.json")
}

###########################################
# ECS Service (connects to VPC & ALB)
###########################################
resource "aws_ecs_service" "app_service" {
  name            = "app-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
    assign_public_ip = true
    security_groups  = [aws_security_group.ecs_sg.id]
  }

  # Load balancer connection (optional, will be used when ALB is added)
  # load_balancer {
  #   target_group_arn = aws_lb_target_group.app_tg.arn
  #   container_name   = "product-service"
  #   container_port   = 8080
  # }

  depends_on = [
    aws_ecs_task_definition.app_task,
    aws_iam_role.ecs_task_execution_role
  ]
}
