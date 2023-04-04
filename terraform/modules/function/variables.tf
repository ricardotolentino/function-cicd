variable "location" {
  description = "The region for the deployment."
  type        = string
}

variable "environment" {
  description = "The name of the environment."
  type        = string
  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "'environment' variable must be one of the following: dev, prod"
  }
}

variable "storage_account_prefix" {
  description = "The prefix for the name of the storage account, which will be suffixed with a random 4 digit number."
  type        = string
  default     = "functioncicd"
}

locals {
  location_map = {
    centralus = "cus"
  }
  location_abv = local.location_map[var.location]

  name_suffix = "-function-cicd-${var.environment}-${local.location_abv}"
}
