
variable "tf_hostname"{
type = string
default = "app.terraform.io"
}

variable "tf_organization" {
  type = string
  default = "gekk0"
}

variable "tf_workspaces" {
  type = set(string)
  default = ["workspaceA", "workspaceB",
    "workspaceC"]
}
