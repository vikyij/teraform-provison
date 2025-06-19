// s3 bucket to store my statefile remotely

resource "aws_s3_bucket" "tf-state" {
  bucket = "vikky-terraform-statefile-192025"

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "global"
  }
}

resource "aws_s3_bucket_versioning" "tf_state_versioning" {
  bucket = aws_s3_bucket.tf-state.id
  versioning_configuration {
    status = "Enabled"
  }
}

// lock statefile 
resource "aws_dynamodb_table" "tf_locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform Lock Table"
    Environment = "global"
  }
}
