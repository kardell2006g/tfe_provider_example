# Configure a TF Workspace ENV Variable called
# “TFE_TOKEN” with the TFC API Token to prevent the token from ending up in the state
terraform {
  required_providers {
    tfe = {
      source = "hashicorp/tfe"
      version = "~> 0.44.1"
    }
    null = {
      source = "hashicorp/null"
      version = "~> 3.1.0"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/tfe/latest/docs
provider "tfe" {
  hostname = var.tf_hostname
}


resource "tfe_workspace" "test" {
  for_each = var.tf_workspaces
  name = each.key
  organization = var.tf_organization
}

output "tf_workspace_ids" {
  value = { for k, v in tfe_workspace.test :
    k => v.id }
}

resource "tfe_variable" "test" {
  for_each = { for k, v in tfe_workspace.test:
    k => v.id }
  key = "test_key_name"
  value = "test_value_name"
  category = "terraform"
  workspace_id = each.value
}

resource "tfe_team" "test" {
  name = "test-team-name"
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
  name         = var.tf_project
  organization = var.tf_organization
}

resource "tfe_team_project_access" "test" {
  access       = "admin"
  team_id      = tfe_team.test.id
  project_id   = tfe_project.test.id
}

