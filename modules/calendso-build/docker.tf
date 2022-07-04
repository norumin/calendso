resource "null_resource" "app_image_builder" {
  triggers = {
    variables = jsonencode([
      var.src_repo,
      var.src_revision,
      var.image_registry,
      var.image_name,
      var.image_tag,
      local.build_args,
    ])
  }

  provisioner "local-exec" {
    command = <<BASH
                docker build ${var.src_repo}#${var.src_revision} \
                  --build-arg NEXT_PUBLIC_WEBAPP_URL=${local.build_args.NEXT_PUBLIC_WEBAPP_URL} \
                  --build-arg NEXT_PUBLIC_APP_URL=${local.build_args.NEXT_PUBLIC_APP_URL} \
                  --build-arg NEXT_PUBLIC_LICENSE_CONSENT=${local.build_args.NEXT_PUBLIC_LICENSE_CONSENT} \
                  --build-arg CALCOM_TELEMETRY_DISABLED=${local.build_args.CALCOM_TELEMETRY_DISABLED} \
                  --build-arg DATABASE_URL=${local.build_args.DATABASE_URL} \
                  --build-arg NEXTAUTH_SECRET=${local.build_args.NEXTAUTH_SECRET} \
                  --build-arg CALENDSO_ENCRYPTION_KEY=${local.build_args.CALENDSO_ENCRYPTION_KEY} \
                  -t ${var.image_registry}/${var.image_name}:latest \
                  -t ${var.image_registry}/${var.image_name}:${var.image_tag}
              BASH
  }

  provisioner "local-exec" {
    command = <<BASH
                docker push --all-tags ${var.image_registry}/${var.image_name}
              BASH
  }
}
