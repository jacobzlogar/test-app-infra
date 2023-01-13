### Setup
1. install [helm](https://helm.sh/docs/intro/install/)

### Packaging
1. (authenticate with docker hub)[https://docs.docker.com/engine/reference/commandline/login/]
2. in the repo of the service you're packaging run:
```
docker build -t yourname/name-of-image .
docker push yourname/name-of-image
```
### Publishing
1. create a `/charts/service-name` directory:
2. copy these files: https://github.com/jacobzlogar/test-app-nestjs/tree/main/charts/test-app-nestjs
3. replace test-app-nestjs in the yaml files with your service name
4. in Values.yaml, replace image.repository with your image, 
```
image:
  repository: yourname/name-of-image
```
5. in the root dir run `mkdir helm`
6. run `helm package ./charts/service-name -d ./helm`
7. `cd helm` 
8. `helm repo index .`
9. your helm dir should contain `index.yaml` and and a gzipped archive

### Create a github pages repo
1. create gh pages for your service repo from the main branch at /
2. point main.tf to the gh pages dir containing index.yaml
```
resource "helm_release" "service-name-deploy" {
  name = "service-name-test-app"
  repository = "https://username.github.io/service-name/helm"
  chart = "chart-name"
}

```
