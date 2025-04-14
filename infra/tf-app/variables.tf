# Define variables for the modules
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group of the project"
  default     = "cst8918-final-project-group-7"
}

variable "location" {
  type        = string
  description = "The Azure region"
  default     = "Canada Central"
}

variable "image_tag" {
  description = "The tag of the Docker image to be used in the Kubernetes deployments"
  type        = string
  default     = "latest"
}