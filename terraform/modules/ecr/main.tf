resource "aws_ecr_repository" "product_repo" {
  name                 = "product-service-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Project = "DevOps-Ecommerce"
    Owner   = "Vignesh"
  }
}
