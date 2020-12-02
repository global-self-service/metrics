variable "production_account" {
  type        = bool
  default     = false
  description = "Enabled only for production AWS account"
}

variable "es_index" {
  type        = string
  description = "Elasticsearch index"
  default     = ""
}

variable "es_version" {
  type        = string
  description = "Elasticsearch version to be used"
}

variable "dashboards" {
  type        = list(string)
  description = "List of Grafana dasboards"
}
