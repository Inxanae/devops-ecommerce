terraform {
  backend "s3" {
    bucket         = "vignesh-terraform-state-12345" 
    key            = "devops-ecommerce/terraform.tfstate"
    region         = "us-east-1" 
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
