terraform {
  backend "s3" {
    bucket         = "vignesh-terraform-state-12345" # your bucket name
    key            = "devops-ecommerce/terraform.tfstate"
    region         = "us-east-1" # your region
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
