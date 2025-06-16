module "ecr_react_frontend" {
  source = "terraform-aws-modules/ecr/aws"
  version = "2.4.0"

  repository_name = "react-frontend"
  

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

   tags = var.tags
}

module "ecr_fastapi" {
  source = "terraform-aws-modules/ecr/aws"
  version = "2.4.0"

  repository_name = "fastapi-api"
  

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

   tags = var.tags
}

module "ecr_celery_worker" {
  source = "terraform-aws-modules/ecr/aws"
  version = "2.4.0"

  repository_name = "celery-worker"
  

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

    tags = var.tags
}

module "ecr_celery_beat" {
  source = "terraform-aws-modules/ecr/aws"
  version = "2.4.0"

  repository_name = "celery-beat"
  

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

   tags = var.tags
}

module "ecr_data_poller" {
  source = "terraform-aws-modules/ecr/aws"
  version = "2.4.0"

  repository_name = "data-poller"
  

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = var.tags
}