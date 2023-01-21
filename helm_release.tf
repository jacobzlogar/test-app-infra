# provider "helm" {
#   debug = true
#   kubernetes {
#     config_path = "~/.kube/config"
#   }
# }
provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
      command     = "aws"
    }
  }
}

resource "helm_release" "redis-deploy" {
  name       = "redis-test-app"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}


resource "helm_release" "soketi-deploy" {
  name       = "soketi-test-app"
  repository = "https://helm.soketi.app"
  chart      = "soketi"
  values = [
    <<EOT
  app:
    extraEnv:
    - name: SOKETI_DEFAULT_APP_ENABLE_CLIENT_MESSAGES
      value: "true"
  EOT
  ]
}


resource "helm_release" "postgresql-deploy" {
  name       = "postgresql-test-app"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  values = [
    <<EOT
  auth:
      enablePostgresUser: true
      postgresPassword: "test"
  global:
      postgresql: 
          auth:
              username: "newuser"
              password: "secret"
  EOT
  ]
}

resource "helm_release" "meilisearch-deploy" {
  name       = "meilisearch-test-app"

  repository = "https://factly.github.io/helm-charts"
  chart      = "meilisearch"
}

resource "helm_release" "nextjs-deploy" {
  name = "nextjs-test-app"
  repository = "https://jacobzlogar.github.io/test-app-nextjs/helm"
  chart = "test-app-nextjs"
}

resource "helm_release" "nestjs-deploy" {
  name = "nestjs-test-app"
  repository = "https://jacobzlogar.github.io/test-app-nestjs/helm"
  chart = "test-app-nestjs"
}
