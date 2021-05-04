# k8s-job-worker-minikube
This repository is designed to deploy applications and services to a minikube kubernetes cluster running locally. Each application/project deployed should be contained in its own folder structure that contains the relavent Terraform configuration files.

## Requirements
- `Minikube (version >= v1.19.0)` is installed and running (kubeconfig should be automatically configured from this)
- `Terraform (version >= v0.15.1)` is installed

## Usage
1. Use the command `minikube start` to spin up a local kubernetes cluster
2. Use the `python-redis-worker-queue` folder as a template to define a new kuberenetes deployment
3. Run `terraform init` within the new folder to initialise the directory
4. Use `terraform apply` to apply the deployment changes
5. Once done, run `terraform destroy` to delete the changes
6. Finally you can use `minikube stop` to pause the cluster or `minikube delete --all` to delete the cluster permenantly