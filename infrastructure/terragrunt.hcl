locals {
  aws_region        = get_env("AWS_REGION")
  gcp_region        = get_env("GCP_REGION")
  gcp_project_id    = get_env("GCP_PROJECT_ID")
  repo_origin       = get_env("REPO_ORIGIN")
  backend_bucket    = get_env("BACKEND_BUCKET")
  backend_locktable = get_env("BACKEND_LOCKTABLE")
  backend_region    = get_env("BACKEND_REGION")

  app_name                = get_env("APP_NAME", "Norumin Scheduling System")
  app                     = get_env("APP", "calendso")
  stage                   = get_env("STAGE", "production")
  domain                  = get_env("DOMAIN", "calendso.norumin.com")
  app_instance_public_key = get_env("APP_INSTANCE_PUBLIC_KEY")

  calendso_ref            = get_env("CALENDSO_REF", "v1.9.1")
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

    provider "google" {
      region                = "${local.gcp_region}"
      project               = "${local.gcp_project_id}"
      billing_project       = "${local.gcp_project_id}"
      user_project_override = true
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
  app_name                = local.app_name
  app                     = local.app
  stage                   = local.stage
  domain                  = local.domain
  app_instance_public_key = local.app_instance_public_key
  calendso_ref            = local.calendso_ref
}
