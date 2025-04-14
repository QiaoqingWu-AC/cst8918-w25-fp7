variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "node_count" {
  type    = number
  default = 1
}

variable "min_count" {
  type    = number
  default = 1
}

variable "max_count" {
  type    = number
  default = 1
}

variable "enable_auto_scaling" {
  type        = bool
  description = "Whether to enable autoscaling in the AKS cluster"
  default     = false
}

