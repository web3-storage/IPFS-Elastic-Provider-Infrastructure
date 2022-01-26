terraform {
  required_version = ">= 1.0.0"
}

provider "aws" {
  profile = var.profile
  region  = var.region
  default_tags {
    tags = {
      Team       = "NearForm"
      Project    = "AWS-IPFS"
      ManagedBy  = "Terraform"
      Example    = "true"
      Production = "false"
    }
  }
}

data "aws_availability_zones" "available" {
}
data "aws_eks_cluster" "eks" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "eks" {
  name = module.eks.cluster_id
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name                 = var.vpc.name
  cidr                 = "10.5.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["10.5.1.0/24", "10.5.2.0/24", "10.5.3.0/24", "10.5.4.0/24"]
  public_subnets       = ["10.5.5.0/24", "10.5.6.0/24", "10.5.7.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "terraform/example"                         = "true"
    "Production"                                = "false"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }

  private_subnet_tags = {
    "terraform/example"                         = "true"
    "Production"                                = "false"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
  }
}

module "eks" {
  source                             = "terraform-aws-modules/eks/aws"
  version                            = "~> 18.2.0"
  cluster_name                       = var.cluster_name
  cluster_version                    = var.cluster_version
  cluster_endpoint_private_access    = true
  cluster_endpoint_public_access     = true
  vpc_id                             = module.vpc.vpc_id
  subnet_ids                         = [module.vpc.private_subnets[0], module.vpc.private_subnets[1]]

  eks_managed_node_groups = { 
    test-ipfs-peer-subsys = {
      name         = "test-ipfs-peer-subsys"
      desired_size = 2
      min_size     = 1
      max_size     = 4

      instance_types = ["t3.large"]
      k8s_labels = {
        workerType = "managed_ec2_node_groups"
      }
      update_config = {
        max_unavailable_percentage = 50
      }

      tags = { # This is also applied to IAM role.
        "eks/505595374361/${var.cluster_name}/type" : "node"
      }
    }
  }

  fargate_profiles = {
    default = {
      name       = "default"
      subnet_ids = [module.vpc.private_subnets[2], module.vpc.private_subnets[3]]
      selectors = [
        {
          namespace = "default"
          labels = {
            workerType = "fargate"
          }
        }
      ]

      tags = { # This is also applied to IAM role.
        "eks/505595374361/${var.cluster_name}/type" : "fargateNode"
      }
      timeouts = {
        create = "5m"
        delete = "5m"
      }
    }
  }  
}

module "eks_auth_sync" {
  source = "../"
  region = var.region
  cluster_name = module.eks.cluster_id
  cluster_oidc_issuer_url = module.eks.cluster_oidc_issuer_url
}

# # # TODO: Replace it witg eks-auth-sync module
# module "kube-base-components" {
#   source                  = "../"
#   cluster_oidc_issuer_url = module.eks.cluster_oidc_issuer_url
#   cluster_id              = module.eks.cluster_id
#   region                  = var.region
#   config_bucket_name      = var.config_bucket_name
#   host                    = data.aws_eks_cluster.eks.endpoint
#   token                   = data.aws_eks_cluster_auth.eks.token
#   cluster_ca_certificate  = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
#   eks_auth_sync_policy_name = "example-eks-auth-sync-policy"
#   eks_auth_sync_role_name = "example-eks-auth-sync-role"
#   service_account_roles = {
#     "bitswap_peer_subsystem_role" = {
#       service_account_name      = "bitswap-irsa",
#       service_account_namespace = "default",
#       role_name                 = "example_bitswap_peer_subsys",
#       policies_list = [
#         aws_iam_policy.config_peer_s3_bucket_policy_read
#       ]
#     },
#   }
# }
