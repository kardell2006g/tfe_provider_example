
variable "tf_hostname"{
type = string
default = "app.terraform.io"
}

variable "tf_organization" {
  type = string
  default = "gekk0"
}

variable "tf_project" {
  type = string
  default = "tfe_pro"
}

variable "tf_workspaces" {
  type = set(string)
  default = ["workspaceA", "workspaceB",
    "workspaceC"]
}
