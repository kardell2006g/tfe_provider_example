
variable "tf_hostname"{
type = string
default = "app.terraform.io"
}

variable "tf_organization" {
  type = string
  default = "gekk0"
}

//variable "tf_project" {
 // type = string
 // default = null
// validation {
  //  condition     = length(var.tf_project) > 2
   // error_message = "Project Names must be at least 3 characters in length"
 // }
//}

variable "tf_workspaces" {
  type = set(string)
 # default = ["workspaceA", "workspaceB", "workspaceC"]
}

variable "environment" {
  type = string
  description = "Environment label corresponding to variable Set environments"
}

variable "testvar_name" {
  type = string
}

variable "testvar_value" {
  type = string
}

variable "team_name" {
  type = string
}

variable "appname" {
   type = string
}

//variable "varset" {
 //  type = string
 //  default = null
//}
//variable "wsname" {
//  type = set(string)
//  default = null
 # default = ["workspaceA", "workspaceB", "workspaceC"]
//}
