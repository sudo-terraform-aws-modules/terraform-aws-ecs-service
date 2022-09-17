variable "name" {
  type        = string
  description = "(optional) Specify the name for the service"
  default     = null
}

variable "cluster_name" {
  type        = string
  description = "Specify the cluster name"
}

variable "task_definition_arn" {
  type        = string
  description = "Specify the Task Defitnion ARN"
}

variable "desired_count" {
  type        = number
  description = "(optional) Specify the desired count for the service"
  default     = 1
}

variable "launch_type" {
  type        = string
  description = "(optional) Specify the launch type. Valid list of values are EC2 or FARGATE. Default: FARGATE"
  default     = "FARGATE"
}

variable "enable_execute_command" {
  type        = bool
  description = "(optional) Enable the ECS Exec on Service. Default: false"
  default     = false
}

variable "subnets" {
  type        = list(string)
  description = "(optional) This is optional with EC2 launch type but required for FARGATE."
  default     = []
}

variable "security_groups" {
  type        = list(string)
  description = "(optional) List of security group IDs."
  default     = []
}

variable "assign_public_ip" {
  type        = bool
  description = "(optional) Assign Public IP or not. Default: false)"
  default     = false
}
