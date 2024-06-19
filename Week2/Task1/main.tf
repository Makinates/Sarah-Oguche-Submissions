provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "artifact_bucket" {
  bucket = "your-unique-artifact-bucket-name"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "artifact_bucket_sse" {
  bucket = aws_s3_bucket.artifact_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_iam_role" "codebuild_role" {
  name = "codebuild-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "codebuild.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      },
    ]
  })

  inline_policy {
    name = "codebuild-policy"
    policy = jsonencode({
      Version = "2012-10-17",
      Statement = [
        {
          Effect = "Allow",
          Action = [
            "s3:GetObject",
            "s3:PutObject",
            "s3:PutObjectAcl"
          ],
          Resource = "arn:aws:s3:::${aws_s3_bucket.artifact_bucket.bucket}/*"
        },
        {
          Effect = "Allow",
          Action = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ],
          Resource = "*"
        }
      ]
    })
  }
}

resource "aws_iam_role" "codepipeline_role" {
  name = "codepipeline-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "codepipeline.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  inline_policy {
    name = "codepipeline-policy"
    policy = jsonencode({
      Version = "2012-10-17",
      Statement = [
        {
          Effect = "Allow",
          Action = [
            "codebuild:BatchGetBuilds",
            "codebuild:StartBuild",
            "s3:GetObject",
            "s3:PutObject",
            "s3:PutObjectAcl"
          ],
          Resource = "*"
        },
        {
          Effect = "Allow",
          Action = [
            "codestar-connections:GetConnection",
            "codestar-connections:ListConnections",
            "codestar-connections:UseConnection"
          ],
          Resource = "arn:aws:codestar-connections:us-east-1:058264070247:connection/0289434c-7382-4359-8fa7-398ce1302069"  // Adjust the ARN to match your specific CodeStar connection ARN
        }
      ]
    })
  }
}

resource "aws_codestarconnections_connection" "github_connection" {
  provider_type = "GitHub"
  name          = "GitHubConnection"
}

resource "aws_codebuild_project" "build_project" {
  name          = "codebuild-realworld-todo"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type     = "S3"
    location = aws_s3_bucket.artifact_bucket.bucket
    name     = "artifact"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:4.0"
    type         = "LINUX_CONTAINER"
  }

  source {
    type      = "GITHUB"
    location  = "https://github.com/SarahUO/realworld"  # Your repository URL
    buildspec = "buildspec.yml"
  }
}

resource "aws_codepipeline" "pipeline" {
  name     = "codepipeline-realworld-todo"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.artifact_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.github_connection.arn
        FullRepositoryId = "SarahUO/realworld"  # Your repository ID
        BranchName       = "main"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]

      configuration = {
        ProjectName = aws_codebuild_project.build_project.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ElasticBeanstalk"
      version         = "1"
      input_artifacts = ["build_output"]

      configuration = {
        ApplicationName = "todo-app"
        EnvironmentName = "todo-app-env"
      }
    }
  }
}
