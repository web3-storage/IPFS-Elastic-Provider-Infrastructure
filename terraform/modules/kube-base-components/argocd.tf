


# resource "kubernetes_manifest" "anapp" {
  
#   manifest = {
#     "apiVersion" = "argoproj.io/v1alpha1"
#     "kind"       = "Application"
#     "metadata" = {
#       "name"      = "bitswap-peer"
#       "namespace" = "default"
#     }
#     "spec" = {
#       project= "default"
#       source= {
#         repoURL= "https://github.com/web3-storage/AWS-IPFS-bitswap-peer.git"
#         targetRevision= "HEAD"
#         path= "helm"
#         helm= {
#           releaseName= "aws-ipfs-bitswap-peer"
#         }
#       }
#       destination= {
#         server= "https://kubernetes.default.svc"
#         namespace= "default"
#       }
#       syncPolicy= {
#         automated= {
#           selfHeal="true"
#           prune= "true"
#         }
#       }
#     }
#   }
# }
