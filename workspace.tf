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

  dynamic "vcs_repo" {
    for_each = var.vcs_repo != null ? [1] : []

    content {
      identifier                 = var.vcs_repo.identifier
      github_app_installation_id = var.vcs_repo.github_app_installation_id
    }
  }
}
