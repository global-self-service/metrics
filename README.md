# Self Service Metrics
This is the repository with terraform code to manage prometheus and grafana setup. It is here we will create custom graphs to monitor gplan-outdoor services.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| dashboards | List of Grafana dasboards | list(string) | n/a | yes |
| es\_version | Elasticsearch version to be used | string | n/a | yes |
| es\_index | Elasticsearch index | string | `""` | no |
| production\_account | Enabled only for production AWS account | bool | `"false"` | no |
