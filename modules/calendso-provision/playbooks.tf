resource "time_sleep" "initial_delay" {
  create_duration = "10s"
}

resource "null_resource" "app_instance_provisioner" {
  depends_on = [
    time_sleep.initial_delay,
  ]

  triggers = {
    src_hash = filesha256("${path.module}/playbooks/app.yml")
    variables = jsonencode([
      data.aws_region.current.name,
      var.app_instance_public_ip,
      var.app_keypair_path,
      local.app_image,
      data.aws_ecr_image.app.image_digest,
      var.app_image_tag,
      var.app_container_count,
      var.app_container_name_prefix,
      var.app_container_ports,
      var.app_container_log_group,
      local.runtime_env,
    ])
  }

  provisioner "local-exec" {
    command = <<BASH
      ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook ${path.module}/playbooks/app.yml \
        -u ubuntu \
        -i '${var.app_instance_public_ip},' \
        --private-key ${var.app_keypair_path} \
        -e 'image=${local.app_image}' \
        -e 'tag=${var.app_image_tag}' \
        -e 'container_count=${var.app_container_count}' \
        -e 'container_name_prefix=${var.app_container_name_prefix}' \
        -e 'ports=${var.app_container_ports}' \
        -e 'awslogs_region=${data.aws_region.current.name}' \
        -e 'awslogs_group=${var.app_container_log_group}' \
        -e '${jsonencode(local.runtime_env)}'
    BASH
  }
}
