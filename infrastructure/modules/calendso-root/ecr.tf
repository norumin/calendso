resource "aws_ecr_repository" "app" {
  name                 = "ecrr-${local.slug}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = merge(local.default_tags, {
    Name = "ecrr-${local.slug}"
  })
}
