variable "region" {
    type = string
    default = "europe-central2"
}
variable "project" {
    type = string
}
variable "user" {
    type = string
}
variable "email" {
    type = string
}
variable "privatekeypath" {
    type = string
    default = "~/.ssh/id_rsa"
}
variable "publickeypath" {
    type = string
    default = "~/.ssh/id_rsa.pub"
}
