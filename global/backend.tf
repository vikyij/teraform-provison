terraform {
  backend "s3" {
    bucket         = "vikky-terraform-statefile-192025"
    key            = "global/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
