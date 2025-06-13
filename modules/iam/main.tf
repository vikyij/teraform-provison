// execution role for ecs
resource "aws_iam_role" "task-execution_role" {
  name = "${var.env}-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}

// attached aws managed ecs task execution policy to ecs execution role
resource "aws_iam_policy_attachment" "execution_role_policy" {
  name = "${var.env}-execution-role-policy-attach"
  roles = [aws_iam_role.task-execution_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

// task role for task
resource "aws_iam_role" "task-role" {
  name = "${var.env}-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Sid = ""
            Principal = {
                Service = "ecs-tasks.amazonaws.com"
            }
        }
    ]
  })
}

// create a task policy for the ecs task role
resource "aws_iam_policy" "custom-task-policy" {
  name        = "${var.env}-task_policy"
  description = "Task policy for task role"
  policy = var.task_policy_json
}


resource "aws_iam_policy_attachment" "task_policy_attach" {
  name = "${var.env}-task-role-policy-attach"
  roles = [aws_iam_role.task-role.name]
  policy_arn = aws_iam_policy.custom-task-policy.arn
}