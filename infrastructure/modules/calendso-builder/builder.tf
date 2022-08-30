resource "time_sleep" "initial_delay" {
  create_duration = "10s"
}

resource "null_resource" "docker_image_builder" {
  depends_on = [
    time_sleep.initial_delay,
  ]

  triggers = {
    src_hash = filesha256("${path.module}/Dockerfile")
    variables = jsonencode([
      //
    ])
  }

  provisioner "local-exec" {
    command = <<BASH
      docker-compose up -d database && docker-compose build app
    BASH

    environment = merge({ STAGE = var.stage }, var.build_env)
  }
}
