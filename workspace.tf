resource "tfe_workspace" "self" {
  allow_destroy_plan  = var.allow_destroy_plan
  auto_apply          = var.auto_apply
  assessments_enabled = var.assessments_enabled
  description         = var.description
  execution_mode      = var.execution_mode
  name                = var.name
  organization        = data.tfe_organization.self.name
  project_id          = data.tfe_project.self.id
  tag_names           = var.tags
}
