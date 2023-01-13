provider "helm" {
  debug = true
  kubernetes {
    config_path = "~/.kube/config"
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

  set {
    name = "service.type"
    value = "NodePort"
  }
}

resource "helm_release" "meilisearch-deploy" {
  name       = "meilisearch-test-app"

  repository = "https://factly.github.io/helm-charts"
  chart      = "meilisearch"

  set {
    name = "postegresqlPassword"
    value = "test-app"
  }
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
