variable "resource_group_name" {
  type        = string
  description = "The name of the resource group of the project"
  default     = "cst8918-final-project-group-7"
}

variable "location" {
  type = string
}

# The image tag for the Docker image
variable "image_tag" {
  description = "The tag of the Docker image to be used in the Kubernetes deployments"
  type        = string
}


variable "acr_login_server" {
  type = string
}

variable "test_redis_hostname" {
  type = string
}

variable "test_redis_key" {
  type = string
  sensitive = true
}

variable "prod_redis_hostname" {
  type = string
}

variable "prod_redis_key" {
  type = string
  sensitive = true
}
