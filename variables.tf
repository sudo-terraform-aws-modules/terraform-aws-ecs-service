variable "name" {
  type        = string
  description = "(optional) Specify the name for the service. Default: randomly generated"
  default     = null
}

variable "cluster_name" {
  type        = string
  description = "Specify the cluster name"
}

variable "task_definition_arn" {
  type        = string
  description = "Specify the Task Definition ARN"
}

variable "desired_count" {
  type        = number
  description = "(optional) Desired number of tasks. Default: 1"
  default     = 1
}

variable "launch_type" {
  type        = string
  description = "(optional) Launch type. Valid values: EC2, FARGATE, EXTERNAL. Default: FARGATE"
  default     = "FARGATE"
  validation {
    condition     = contains(["EC2", "FARGATE", "EXTERNAL"], var.launch_type)
    error_message = "Valid values for launch_type are: EC2, FARGATE, EXTERNAL."
  }
}

variable "scheduling_strategy" {
  type        = string
  description = "(optional) Scheduling strategy. Valid values: REPLICA, DAEMON. Default: REPLICA"
  default     = "REPLICA"
  validation {
    condition     = contains(["REPLICA", "DAEMON"], var.scheduling_strategy)
    error_message = "Valid values for scheduling_strategy are: REPLICA, DAEMON."
  }
}

variable "enable_execute_command" {
  type        = bool
  description = "(optional) Enable ECS Exec on the service. Requires a task role with SSM permissions. Default: false"
  default     = false
}

variable "propagate_tags" {
  type        = string
  description = "(optional) Propagate tags from SERVICE or TASK_DEFINITION to tasks. Default: SERVICE"
  default     = "SERVICE"
  validation {
    condition     = contains(["SERVICE", "TASK_DEFINITION", "NONE"], var.propagate_tags)
    error_message = "Valid values for propagate_tags are: SERVICE, TASK_DEFINITION, NONE."
  }
}

variable "wait_for_steady_state" {
  type        = bool
  description = "(optional) Wait for the service to reach a steady state before completing apply. Default: false"
  default     = false
}

variable "subnets" {
  type        = list(string)
  description = "(optional) Subnet IDs for the service. Required for FARGATE launch type."
  default     = []
}

variable "security_groups" {
  type        = list(string)
  description = "(optional) Security group IDs for the service."
  default     = []
}

variable "assign_public_ip" {
  type        = bool
  description = "(optional) Assign a public IP to the task ENI. Default: false"
  default     = false
}

variable "target_group_arn" {
  type        = string
  description = "(optional) ARN of the load balancer target group. When set, a load_balancer block is created."
  default     = null
}

variable "container_name" {
  type        = string
  description = "(optional) Container name to associate with the load balancer. Required when target_group_arn is set."
  default     = null
}

variable "container_port" {
  type        = number
  description = "(optional) Container port to associate with the load balancer. Required when target_group_arn is set."
  default     = null
}

variable "health_check_grace_period_seconds" {
  type        = number
  description = "(optional) Seconds to wait after a task starts before health checks count against it. Only applies when target_group_arn is set. Default: 30"
  default     = 30
}

variable "capacity_provider_name" {
  type        = string
  description = "(optional) Capacity provider name. When set, a capacity_provider_strategy block is created and launch_type is ignored."
  default     = null
}

variable "capacity_provider_weight" {
  type        = number
  description = "(optional) Capacity provider weight. Required when capacity_provider_name is set."
  default     = null
}

variable "enable_deployment_circuit_breaker" {
  type        = bool
  description = "(optional) Enable deployment circuit breaker to stop a failed deployment. Default: true"
  default     = true
}

variable "enable_deployment_rollback" {
  type        = bool
  description = "(optional) Automatically roll back when deployment circuit breaker triggers. Default: true"
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "(optional) Tags to apply to the ECS service."
  default     = {}
}
