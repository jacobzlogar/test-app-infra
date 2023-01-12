provider "helm" {
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
  set {
    name = "extraEnv"
    value = jsonencode(["SOKETI_DEBUG=1", "PORT=6969", "SOKETI_ADAPTER_DRIVER=redis"]) # dont think this is correct
  }


  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}


resource "helm_release" "postgresql-deploy" {
  name       = "postgresql-test-app"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
}

resource "helm_release" "meilisearch-deploy" {
  name       = "meilisearch-test-app"

  repository = "https://factly.github.io/helm-charts"
  chart      = "meilisearch"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}

resource "helm_release" "nextjs-deploy" {
  name = "nextjs-test-app"
  repository = "https://jacobzlogar.github.io/nextjs-k8s"
  chart = "nextjs-k8s"
}
