variable "agent_pool_id" {
  default     = null
  description = "ID of the agent pool to associate with the workspace."
  type        = string
}

variable "allow_destroy_plan" {
  default     = false
  description = "Whether to allow the creation of destroy plans."
  type        = bool
}

variable "assessments_enabled" {
  default     = false
  description = "Whether to enable health assesments."
  type        = bool
}

variable "auto_apply" {
  default     = false
  description = "Whether to automatically apply changes when a Terraform plan is successful."
  type        = bool
}

variable "description" {
  description = "The description of the workspace to create."
  type        = string
}

variable "execution_mode" {
  default     = "remote"
  description = "The execution mode of the workspace to create."
  type        = string
}

variable "name" {
  description = "The name of the workspace to create."
  type        = string
}

variable "organization_name" {
  description = "The name of the organization to use."
  type        = string
}

variable "project_name" {
  description = "The name of the project to use."
  type        = string
}

variable "tags" {
  default     = []
  description = "A list of tags to add to the workspace."
  type        = list(string)
}

variable "variable_set_ids" {
  default     = []
  description = "A list of variable set IDs to associate with the workspace."
  type        = list(string)
}

variable "variables" {
  default     = []
  description = "A list of variables to add to the workspace."
  type = list(object({
    category    = string
    description = optional(string)
    hcl         = optional(bool)
    key         = string
    sensitive   = optional(bool)
    value       = string
  }))
}

variable "vcs_repo" {
  default     = null
  description = "The VCS repository to associate with the workspace."
  type = object({
    github_app_installation_id = string
    identifier                 = string
  })
}
