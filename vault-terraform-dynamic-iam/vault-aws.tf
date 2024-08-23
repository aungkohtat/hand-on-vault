#To enable aws secret engine and configure
resource "vault_aws_secret_backend" "aws" {
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  region = "ap-southeast-1"
  path = "tf-vault-aws"
  #To limit the lease ttl
  default_lease_ttl_seconds = 120
  max_lease_ttl_seconds = 240
  #To ignore the aws access key and aws secret key although if vault rotate by
  lifecycle {
    ignore_changes = [
      access_key, secret_key
    ]
  }
}

#To create vault role with policy
resource "vault_aws_secret_backend_role" "role" {
  backend = vault_aws_secret_backend.aws.path
  name    = "vault-role-admin"
  credential_type = "iam_user"

  policy_document = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "iam:*",
      "Resource": "*"
    }
  ]
}
EOT
 
}

#To read and create dyanamic iam user
data "vault_aws_access_credentials" "creds" {
  backend = vault_aws_secret_backend.aws.path
  role    = vault_aws_secret_backend_role.role.name

}