output "vault_server1_auth_list" {
  value = data.vault_auth_backends.vault-dev-server1.paths
}

output "vault_server1_config_list" {
  value = resource.vault_aws_secret_backend.aws.path
  # sensitive = true
}

output "vault_server1_creds_list" {
  value = data.vault_aws_access_credentials.creds
  sensitive = true
}
