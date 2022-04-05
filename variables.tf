variable "region" {
    type = string
    default = "europe-central2"
}
variable "project" {
    type = string
    default = "development-345907"
}
variable "user" {
    type = string
    default = "terraform_service_account"
}
variable "email" {
    type = string
    default = "dj-serviceaccount@development-345907.iam.gserviceaccount.com"
}
variable "privatekeypath" {
    type = string
    default = "~/.ssh/id_rsa"
}
variable "publickeypath" {
    type = string
    default = "~/.ssh/id_rsa.pub"
}
