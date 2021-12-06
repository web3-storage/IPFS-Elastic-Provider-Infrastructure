provider "kubernetes" {
  host                   = var.host
  token                  = var.token
  cluster_ca_certificate = var.cluster_ca_certificate
}

resource "kubernetes_service_account" "irsa" {
  metadata {
    name      = local.service_account_name
    namespace = local.service_account_namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = module.iam_assumable_role_admin.iam_role_arn
    }
  }
}
