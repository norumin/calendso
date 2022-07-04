resource "null_resource" "app_instance_provisioner" {
  triggers = {
    src_hash = filesha256("${path.module}/playbooks/app.yml")
    variables = jsonencode([
      var.app_instance_public_ip,
      var.app_privkey_path,
      var.stage,
      var.app_image,
      var.app_image_tag,
      var.app_container_count,
      var.app_container_name_prefix,
      local.app_container_env,
      var.app_container_ports,
      data.aws_region.current.name,
      var.app_container_log_group,
    ])
  }

  provisioner "local-exec" {
    command = <<BASH
                sleep 10s && ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook ${path.module}/playbooks/app.yml \
                  -u ubuntu \
                  -i '${var.app_instance_public_ip},' \
                  --private-key ${var.app_privkey_path} \
                  -e 'stage=${var.stage}' \
                  -e 'image=${var.app_image}' \
                  -e 'tag=${var.app_image_tag}' \
                  -e 'container_count=${var.app_container_count}' \
                  -e 'container_name_prefix=${var.app_container_name_prefix}' \
                  -e '${jsonencode({ env = local.app_container_env })}' \
                  -e 'ports=${var.app_container_ports}' \
                  -e 'awslogs_region=${data.aws_region.current.name}' \
                  -e 'awslogs_group=${var.app_container_log_group}'
              BASH
  }
}
