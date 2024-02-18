# SUDO AWS Terrafor Module for ECS Service
This module creates a secure and compliance ECS service.

## Usage
```
module "ecs_service" {
  source              = "github.com/sudo-terraform-aws-modules/terraform-aws-ecs-service?ref=v1.0.2"

  cluster_name        = module.ecs_cluster.name
  task_definition_arn = module.ecs_task.task_definition_arn
  subnets             = module.vpc.private_subnets # TODO: Change to private subnets
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.67 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.31.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecs_service.service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [random_string.random_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | (optional) Assign Public IP or not. Default: false) | `bool` | `false` | no |
| <a name="input_capacity_provider_name"></a> [capacity\_provider\_name](#input\_capacity\_provider\_name) | (optional) Capacity provider name | `string` | `null` | no |
| <a name="input_capacity_provider_weight"></a> [capacity\_provider\_weight](#input\_capacity\_provider\_weight) | (optional) Capacity provider Weight | `string` | `null` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Specify the cluster name | `string` | n/a | yes |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | (optional) Container Name | `string` | `null` | no |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | (optional) Container Port | `string` | `null` | no |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | (optional) Specify the desired count for the service | `number` | `1` | no |
| <a name="input_enable_execute_command"></a> [enable\_execute\_command](#input\_enable\_execute\_command) | (optional) Enable the ECS Exec on Service. Default: false | `bool` | `false` | no |
| <a name="input_launch_type"></a> [launch\_type](#input\_launch\_type) | (optional) Specify the launch type. Valid list of values are EC2 or FARGATE. Default: FARGATE | `string` | `"FARGATE"` | no |
| <a name="input_name"></a> [name](#input\_name) | (optional) Specify the name for the service | `string` | `null` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | (optional) List of security group IDs. | `list(string)` | `[]` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | (optional) This is optional with EC2 launch type but required for FARGATE. | `list(string)` | `[]` | no |
| <a name="input_target_group_arn"></a> [target\_group\_arn](#input\_target\_group\_arn) | (optional) Target Group ARN | `string` | `null` | no |
| <a name="input_task_definition_arn"></a> [task\_definition\_arn](#input\_task\_definition\_arn) | Specify the Task Defitnion ARN | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
