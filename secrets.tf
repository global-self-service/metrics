provider "vault" {}

data "vault_generic_secret" "datasource" {
  path = "secret/self-service/envs/${local.environment}/elasticsearch/datasource"
}

data "vault_generic_secret" "grafana" {
  path = "secret/self-service/envs/${local.environment}/grafana"
}

locals {
  es_username                  = data.vault_generic_secret.datasource.data["username"]
  es_password                  = data.vault_generic_secret.datasource.data["password"]
  es_url                       = data.vault_generic_secret.datasource.data["url"]
  client_id                    = data.vault_generic_secret.grafana.data["client_id"]
  client_secret                = data.vault_generic_secret.grafana.data["client_secret"]
  oauth_authorization_endpoint = data.vault_generic_secret.grafana.data["oauth_authorization_endpoint"]
  oauth_token_endpoint         = data.vault_generic_secret.grafana.data["oauth_token_endpoint"]
}
