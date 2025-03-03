provider "aws" {}

data "aws_caller_identity" "current" {}

output "data" {
    value = data.aws_caller_identity.current.id
}