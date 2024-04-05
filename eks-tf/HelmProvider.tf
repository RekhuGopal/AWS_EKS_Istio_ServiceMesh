# provider "helm" {
#   kubernetes {
#     host                   = aws_eks_cluster.demo.endpoint
#     cluster_ca_certificate = base64decode(aws_eks_cluster.demo.certificate_authority[0].data)
#     exec {
#       api_version = "client.authentication.k8s.io/v1beta1"
#       args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.demo.id]
#       command     = "aws"
#     }
#   }
# }

#provider "helm" {
#  kubernetes {
#    config_path = "~/.kube/config"
#  }
#}

data "aws_eks_cluster" "eks" {
  name = "demo"

  depends_on = [aws_eks_cluster.demo]
}

data "aws_eks_cluster_auth" "eks" {
  name = "demo"

  depends_on = [aws_eks_cluster.demo]
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}