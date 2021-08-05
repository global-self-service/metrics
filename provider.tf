provider "aws" {
  region = "eu-west-1"
}

provider "vault" {}

data "aws_eks_cluster" "cluster" {
  name = local.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)

  experiments {
    manifest_resource = true
  }

  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    args        = ["token", "--cluster-id", local.cluster_name]
    command     = "aws-iam-authenticator"
  }
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)

    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      args        = ["token", "--cluster-id", local.cluster_name]
      command     = "aws-iam-authenticator"
    }
  }
}
