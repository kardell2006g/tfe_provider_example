# Configure a TF Workspace ENV Variable called
# “TFE_TOKEN” with the TFC API Token to prevent the token from ending up in the state
terraform {
  required_providers {
    tfe = {
      source = "hashicorp/tfe"
      version = "~> 0.48.0"
    }
    null = {
      source = "hashicorp/null"
      version = "~> 3.1.0"
    }
  }
}

locals {
  varset = "${var.team_name}-${var.environment}-set"
  tf_project = "${var.team_name}-${var.appname}"
 }


# https://registry.terraform.io/providers/hashicorp/tfe/latest/docs
provider "tfe" {
  hostname = var.tf_hostname
}

resource "tfe_workspace" "test" {
  for_each = var.tf_workspaces
  name = each.key
  organization = var.tf_organization
  project_id = tfe_project.test.id
}

output "tf_workspace_ids" {
  value = { for k, v in tfe_workspace.test :
    k => v.id }
}

resource "tfe_variable" "test" {
  for_each = { for k, v in tfe_workspace.test:
    k => v.id }
  key = var.testvar_name
  value = var.testvar_value
  category = "terraform"
  workspace_id = each.value
}

resource "tfe_team" "test" {
  name = var.team_name
  organization = var.tf_organization
}

resource "tfe_team_access" "test" {
  for_each = { for k, v in tfe_workspace.test:
    k => v.id }
  access = "read"
  team_id = tfe_team.test.id
  workspace_id = each.value
}
   
  resource "tfe_project" "test" {
  name         = local.tf_project
  organization = var.tf_organization
}

resource "tfe_team_project_access" "test" {
  access       = "admin"
  team_id      = tfe_team.test.id
  project_id   = tfe_project.test.id
}

data "tfe_variable_set" "test" {
  name         = local.varset
  organization = var.tf_organization
}

resource "tfe_workspace_variable_set" "test"{
    for_each = { for k, v in tfe_workspace.test:
    k => v.id }
  variable_set_id   = data.tfe_variable_set.test.id
  workspace_id      = each.value
}



