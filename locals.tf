locals {
  service_name    = var.name == null ? "sudo-sv-${random_string.random_name[0].result}" : var.name
  is_launch_type  = var.capacity_provider_name != null && var.capacity_provider_weight != null ? null : true
  launch_type_var = var.launch_type != null ? var.launch_type : "FARGATE"
  launch_type     = local.is_launch_type != null ? local.launch_type_var : null
}

resource "random_string" "random_name" {
  count   = var.name == null ? 1 : 0
  length  = 8
  special = false
  upper   = false
}
