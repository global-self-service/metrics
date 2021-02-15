module "metrics" {
  source = "github.com/global-devops-terraform/k8s-metrics?ref=v0.132.0"

  read_access_groups = {
    "devaccess" = ["devaccess"]
  }

  allowed_cidr            = module.common.global_lan_cidr
  allowed_sg              = [module.common.ct_team_eks_woker_sg, module.common.devops_team_eks_woker_sg]
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

  external_labels = {
    environment = "selfservice-${local.environment}"
  }

  sso_config = {
    sso_enabled    = true
    client_id      = local.client_id
    client_secret  = local.client_secret
    auth_url       = local.oauth_authorization_endpoint
    token_url      = local.oauth_token_endpoint
    allowed_groups = [module.common.azure_groups["devops"]]
  }

  blackbox_target_urls = []
}

locals {
  scrape_configs = []
}
