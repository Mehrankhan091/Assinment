# In this file put the variables related to the deployment
variable "bucket_name" {
    type = string
    default = "prod-assinment-bucket"
    
}
variable "environment" {
    type = string
    default = "prod"
    
}

variable "logbucket" {
    type = string
    default = "mytestlog120977574"
}