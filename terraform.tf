provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket         = "global-self-service-dev-terraform-state"
    key            = "metrics.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

data "aws_eks_cluster" "eks-cluster" {
  name = local.cluster_name
}

data "aws_eks_cluster_auth" "eks-cluster" {
  name = local.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks-cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks-cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.eks-cluster.token
  load_config_file       = false
}
