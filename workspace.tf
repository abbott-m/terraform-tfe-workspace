resource "tfe_workspace" "self" {
  agent_pool_id       = var.agent_pool_id
  allow_destroy_plan  = var.allow_destroy_plan
  assessments_enabled = var.assessments_enabled
  auto_apply          = var.auto_apply
  description         = var.description
  execution_mode      = var.execution_mode
  name                = var.name
  organization        = data.tfe_organization.self.name
  project_id          = var.project_id
  tag_names           = var.tags

  dynamic "vcs_repo" {
    for_each = var.vcs_repo != null ? [1] : []

    content {
      identifier                 = var.vcs_repo.identifier
      github_app_installation_id = var.vcs_repo.github_app_installation_id
    }
  }
}

resource "tfe_variable" "self" {
  for_each = { for v in var.variables : v.key => v }

  category     = each.value.category
  description  = each.value.description
  hcl          = each.value.hcl
  key          = each.value.key
  sensitive    = each.value.sensitive
  value        = each.value.value
  workspace_id = tfe_workspace.self.id
}

resource "tfe_workspace_variable_set" "self" {
  for_each = toset(var.variable_set_ids)

  variable_set_id = each.key
  workspace_id    = tfe_workspace.self.id
}
