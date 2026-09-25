# SUDO AWS Terraform Module for ECS Service

This module creates a secure and configurable ECS service supporting Fargate and EC2 launch types, optional load balancer integration, capacity provider strategies, and deployment circuit breakers.

## Usage

### Basic Fargate Service

```hcl
module "ecs_service" {
  source  = "sudo-terraform-aws-modules/ecs-service/aws"
  version = "1.0.0"

  name                = "my-service"
  cluster_name        = module.ecs_cluster.name
  task_definition_arn = module.ecs_task.task_definition_arn
  subnets             = module.vpc.private_subnets
  security_groups     = [aws_security_group.service.id]
}
```

### Fargate Service with Load Balancer

```hcl
module "ecs_service" {
  source  = "sudo-terraform-aws-modules/ecs-service/aws"
  version = "1.0.0"

  name                = "my-service"
  cluster_name        = module.ecs_cluster.name
  task_definition_arn = module.ecs_task.task_definition_arn
  desired_count       = 2
  subnets             = module.vpc.private_subnets
  security_groups     = [aws_security_group.service.id]

  target_group_arn                  = aws_lb_target_group.this.arn
  container_name                    = "app"
  container_port                    = 8080
  health_check_grace_period_seconds = 60

  tags = {
    Environment = "prod"
  }
}
```

### Service with Capacity Provider (instead of launch type)

```hcl
module "ecs_service" {
  source  = "sudo-terraform-aws-modules/ecs-service/aws"
  version = "1.0.0"

  name                     = "my-service"
  cluster_name             = module.ecs_cluster.name
  task_definition_arn      = module.ecs_task.task_definition_arn
  subnets                  = module.vpc.private_subnets
  capacity_provider_name   = "FARGATE_SPOT"
  capacity_provider_weight = 1
}
```

### Service with ECS Exec enabled

```hcl
module "ecs_service" {
  source  = "sudo-terraform-aws-modules/ecs-service/aws"
  version = "1.0.0"

  name                   = "my-service"
  cluster_name           = module.ecs_cluster.name
  task_definition_arn    = module.ecs_task.task_definition_arn
  subnets                = module.vpc.private_subnets
  enable_execute_command = true  # requires task_role_arn with SSM permissions
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0, < 7.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.0, < 7.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1 |

## Resources

| Name | Type |
|------|------|
| [aws_ecs_service.service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [random_string.random_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Cluster name to deploy the service into | `string` | n/a | yes |
| <a name="input_task_definition_arn"></a> [task\_definition\_arn](#input\_task\_definition\_arn) | Task Definition ARN to use for the service | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Service name. Default: randomly generated | `string` | `null` | no |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | Desired number of running tasks | `number` | `1` | no |
| <a name="input_launch_type"></a> [launch\_type](#input\_launch\_type) | Launch type: EC2, FARGATE, or EXTERNAL. Ignored when capacity\_provider\_name is set | `string` | `"FARGATE"` | no |
| <a name="input_scheduling_strategy"></a> [scheduling\_strategy](#input\_scheduling\_strategy) | Scheduling strategy: REPLICA or DAEMON | `string` | `"REPLICA"` | no |
| <a name="input_enable_execute_command"></a> [enable\_execute\_command](#input\_enable\_execute\_command) | Enable ECS Exec. Requires a task role with SSM permissions | `bool` | `false` | no |
| <a name="input_propagate_tags"></a> [propagate\_tags](#input\_propagate\_tags) | Propagate tags from SERVICE, TASK\_DEFINITION, or NONE | `string` | `"SERVICE"` | no |
| <a name="input_wait_for_steady_state"></a> [wait\_for\_steady\_state](#input\_wait\_for\_steady\_state) | Wait for service to reach steady state on apply | `bool` | `false` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Subnet IDs. Required for FARGATE launch type | `list(string)` | `[]` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | Security group IDs | `list(string)` | `[]` | no |
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | Assign a public IP to the task ENI | `bool` | `false` | no |
| <a name="input_target_group_arn"></a> [target\_group\_arn](#input\_target\_group\_arn) | Load balancer target group ARN. When set, creates a load\_balancer block | `string` | `null` | no |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | Container name to register with the load balancer. Required when target\_group\_arn is set | `string` | `null` | no |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | Container port to register with the load balancer. Required when target\_group\_arn is set | `number` | `null` | no |
| <a name="input_health_check_grace_period_seconds"></a> [health\_check\_grace\_period\_seconds](#input\_health\_check\_grace\_period\_seconds) | Seconds to ignore health checks after task startup. Only applies when target\_group\_arn is set | `number` | `30` | no |
| <a name="input_capacity_provider_name"></a> [capacity\_provider\_name](#input\_capacity\_provider\_name) | Capacity provider name. When set, creates a capacity\_provider\_strategy block and ignores launch\_type | `string` | `null` | no |
| <a name="input_capacity_provider_weight"></a> [capacity\_provider\_weight](#input\_capacity\_provider\_weight) | Capacity provider weight. Required when capacity\_provider\_name is set | `number` | `null` | no |
| <a name="input_enable_deployment_circuit_breaker"></a> [enable\_deployment\_circuit\_breaker](#input\_enable\_deployment\_circuit\_breaker) | Stop a failing deployment automatically | `bool` | `true` | no |
| <a name="input_enable_deployment_rollback"></a> [enable\_deployment\_rollback](#input\_enable\_deployment\_rollback) | Roll back automatically when the circuit breaker triggers | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the ECS service | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | ECS Service ID |
| <a name="output_name"></a> [name](#output\_name) | ECS Service name |
| <a name="output_cluster"></a> [cluster](#output\_cluster) | ECS Cluster the service belongs to |
<!-- END_TF_DOCS -->
