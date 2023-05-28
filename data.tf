data "tfe_project" "self" {
  name         = var.project_name
  organization = data.tfe_organization.self.name
}

data "tfe_organization" "self" {
  name = var.organization_name
}
