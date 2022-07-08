# Collection of test terraform config files
## Digitalocean
Basic Kubernetes cluster setup with 1 * 2vCPU/2GB worker nodes and autscale pool of 1-5 * 2vCPU/2GB nodes
State will be stored inside DO preconfigured space so you need to place `access_key` and `secret_key` inside backend_config.hcl and init terraform using


First you need to set up kubernetes cluster
```bash
cd do/kubecluster
terraform init --backend-config=./backend_config.hcl
terraform apply -var-file=../variables.tfvars
```
Then set up all resources
```bash
cd ../resources
terraform init --backend-config=./backend_config.hcl
terraform apply -var-file=../variables.tfvars
```
