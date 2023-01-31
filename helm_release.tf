# resource "helm_release" "redis-deploy" {
#   name       = "redis-test-app"

#   repository = "https://charts.bitnami.com/bitnami"
#   chart      = "redis"

#   set {
#     name  = "service.type"
#     value = "ClusterIP"
#   }
# }


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
  service:
    type: LoadBalancer
  ingress:
    enabled: true
    className: nginx
    hosts:
      - host: middlechats.com
        paths:
          - /
        backend:
          service:
            name: soketi-test-app
            port:
              number: 6001
  EOT
  ]
}


# resource "helm_release" "postgresql-deploy" {
#   name       = "postgresql-test-app"

#   repository = "https://charts.bitnami.com/bitnami"
#   chart      = "postgresql"
#   values = [
#     <<EOT
#   auth:
#       enablePostgresUser: true
#       postgresPassword: "test"
#   global:
#       postgresql:
#           auth:
#               username: "newuser"
#               password: "secret"
#   EOT
#   ]
# }

# resource "helm_release" "meilisearch-deploy" {
#   name       = "meilisearch-test-app"

#   repository = "https://factly.github.io/helm-charts"
#   chart      = "meilisearch"
# }

resource "helm_release" "nginx-ingress-deploy" {
  name = "nginx-test-app"
  repository = "https://helm.nginx.com/stable"
  chart      = "nginx-ingress"
}

resource "helm_release" "nextjs-deploy" {
  name = "nextjs-test-app"
  repository = "https://jacobzlogar.github.io/test-app-nextjs/helm"
  chart = "middlechat-nextjs"
  # values = [
  # <<EOT
  # service:
  #   type: LoadBalancer
  # ingress:
  #   enabled: true
  #   className: nginx
  #   hosts:
  #     - host: middlechats.com
  #       paths:
  #         - pathType: Prefix
  #           path: "/"
  #           backend:
  #             service:
  #               name: middlechat-nextjs
  #               port:
  #                 number: 3000
  # EOT
  # ]
}

# resource "helm_release" "nestjs-deploy" {
#   name = "nestjs-test-app"
#   repository = "https://jacobzlogar.github.io/test-app-nestjs/helm"
#   chart = "test-app-nestjs"
# }
