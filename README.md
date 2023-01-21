# test-app-infra

## Setup
#### install [terraform](https://developer.hashicorp.com/terraform/downloads?product_intent=terraform)
#### install [minikube](https://developer.hashicorp.com/terraform/downloads?product_intent=terraform)

1. cd `/eks`
2. `terraform init`
3. `terraform apply` this will take awhile

## Run

``` sh
terraform apply -auto-approve
kubectl port-forward svc/soketi-test-app 6001:6001
kubectl port-froward svc/test-app-nextjs 3000:80
```

