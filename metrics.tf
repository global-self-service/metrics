module "metrics" {
  source = "github.com/global-devops-terraform/k8s-metrics?ref=v0.175.0"

  read_access_groups = {
    "devaccess" = ["devaccess"]
  }

  allowed_cidr            = module.common.global_lan_cidr
  allowed_prefixes        = flatten([module.common.prefix_list_teams, module.common.prefix_list_devops])
  cluster_name            = local.cluster_name
  cluster_oidc_issuer_url = local.cluster_oidc_issuer_url
  environment_label       = "selfservice-${local.environment}"
  extra_prometheus_config = local.scrape_configs
  ingress_lb_sg           = local.cluster_sg
  log_group_name          = local.environment
  logging_bucket          = local.logging_bucket
  metrics_allowed_sg      = [local.cluster_sg]
  recording_rules         = local.recording_rules
  vpc_id                  = local.vpc_id
  zone_id                 = local.zone_id
  zone_name               = local.domain_name
  prometheus_trusted_ips  = local.trusted_ips

  external_labels = {
    environment = "selfservice-${local.environment}"
  }

  sso_config = {
    sso_enabled    = true
    client_id      = local.client_id
    client_secret  = local.client_secret
    auth_url       = module.common.azure_auth_url
    token_url      = module.common.azure_token_url
    allowed_groups = [module.common.azure_groups["devops"]]
    tenant_id      = module.common.azure_tenant_id
  }

  blackbox_target_urls = []
}

data "aws_ec2_managed_prefix_list" "trusted_ips" {
  for_each = toset(flatten([module.common.prefix_list_teams, module.common.prefix_list_devops]))

  id = each.value
}

locals {
  trusted_ips = flatten([for k, v in data.aws_ec2_managed_prefix_list.trusted_ips : v.entries[*].cidr])

  scrape_configs = []
}
