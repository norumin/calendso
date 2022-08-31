resource "time_sleep" "initial_delay" {
  create_duration = "10s"
}

resource "null_resource" "docker_image_builder" {
  depends_on = [
    time_sleep.initial_delay,
  ]

  triggers = {
    builder_src_hash = sha1(join("",
      [for f in fileset("${path.module}/builder", "*") : filesha1("${path.module}/builder/${f}")]
    ))
    variables = jsonencode([
      local.ecr_url,
      var.stage,
      var.calendso_ref,
      var.build_env,
    ])
  }

  provisioner "local-exec" {
    command = <<BASH
      docker-compose -f ${path.module}/builder/docker-compose.yml up -d database && \
      docker-compose -f ${path.module}/builder/docker-compose.yml build app && \
      docker-compose -f ${path.module}/builder/docker-compose.yml down && \
      echo "${local.ecr_token}" | docker login -u AWS --password-stdin ${local.ecr_url} && \
      docker tag builder_app:latest ${local.ecr_url}:latest && \
      docker push ${local.ecr_url}:latest && \
      docker logout ${local.ecr_url} && \
      docker rmi ${local.ecr_url}:latest
    BASH

    environment = merge({ STAGE = var.stage, CALENDSO_REF = var.calendso_ref }, var.build_env)
  }
}
