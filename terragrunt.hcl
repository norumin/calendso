locals {
  aws_region        = get_env("AWS_REGION")
  repo_origin       = get_env("REPO_ORIGIN")
  backend_bucket    = get_env("BACKEND_BUCKET")
  backend_locktable = get_env("BACKEND_LOCKTABLE")
  backend_region    = get_env("BACKEND_REGION")

  app_name = get_env("APP_NAME", "Norumin Scheduling System")
  app      = get_env("APP", "calendso")
  stage    = get_env("STAGE", "production")
  domain   = get_env("DOMAIN", "calendso.norumin.com")
}

generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "aws" {
  region = "${local.aws_region}"

  default_tags {
    tags = {
      Repo = "${local.repo_origin}"
    }
  }
}
  EOF
}

remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    region         = local.backend_region
    dynamodb_table = local.backend_locktable
    bucket         = local.backend_bucket
    key            = "env:/${local.stage}/${local.app}/terraform.tfstate"
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

inputs = {
  app_name = local.app_name
  app      = local.app
  stage    = local.stage
  domain   = local.domain
}
