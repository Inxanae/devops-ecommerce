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
load_balancer {
  target_group_arn = aws_lb_target_group.app_tg.arn
  container_name   = "product-service"
  container_port   = 8080
}

depends_on = [aws_lb_listener.app_listener]
