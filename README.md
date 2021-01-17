# Collection of test terraform config files
## Digitalocean
Basic Kubernetes cluster setup with 2*2vCPU/2GB worker nodes
State will be stored inside DO precinfigured space so you need to place `access_key` and `secret_key` inside backend_config.hcl and init terraform using
```bash
terraform init --backend-config=./backend_config.hcl
```