locals {
  datasources = {
    "elasticsearch" = {
      url      = local.es_url
      username = local.es_username
      password = local.es_password
      index    = var.es_index
      version  = var.es_version
    }
  }
}

module "grafana" {
  source = "github.com/global-devops-terraform/k8s-namespace?ref=v0.17.0"

  cluster_name = local.cluster_name
  namespace    = module.metrics.namespace

  create_namespace = false

  config_maps = {
    for n in var.dashboards : "${n}-dashboard" => {
      labels = {
        "grafana_dashboard" = true
      }

      data = {
        "${n}-dashboard.json" = file("dashboards/${n}.json")
      }
    }
  }

  secrets = {
    for k, v in local.datasources : "${k}-datasource" => {
      type = "Opaque"

      labels = {
        "grafana_datasource" = true
      }

      data = {
        "${k}-datasource.yaml" = templatefile("datasources/${k}.yaml", v)
      }
    }
  }
}
