# Creating Dyanamic IAM User by Vault+Terraform

## Running Vault Server on Local Machine


```
vault server -dev
```

## set the Vault Address Environment Variable



```
export VAULT_ADDR='http://127.0.0.1:8200'

```
![](./images/Screenshot%202024-08-24%20at%2012.14.22 AM.png)


![](./images/Screenshot%202024-08-24%20at%2012.16.08 AM.png)

## Set AWS Access Keys as Environment Variables

```
export AWS_ACCESS_KEY_ID= "xxxxxxxxxxxx"
export AWS_SECRET_ACCESS_KEY= "xxxxxxxxxxxxxxxxxxx"
```

## Install Terraform
```
chmod +x install-aws.sh
./install-aws.sh
```
## install terraform 
```
chmod +x install-terraform.sh
./install-terraform.sh
```


## Terraform Configuration

- terraform init

![](./images/Screenshot%202024-08-24%20at%2012.45.28 AM.png)

- terraform plan

![](./images/Screenshot%202024-08-24%20at%2012.47.30 AM.png)

- terraform apply

![](./images/Screenshot%202024-08-24%20at%2012.52.33 AM.png)

- terraform output -json
![](./images/Screenshot%202024-08-24%20at%2012.54.38 AM.png)


## verify vault ui

![](./images/Screenshot%202024-08-24%20at%2012.57.16 AM.png)


![](./images/Screenshot%202024-08-24%20at%2012.58.13 AM.png)


![](./images/Screenshot%202024-08-24%20at%2012.58.48 AM.png)


- vault write -f tf-vault-aws/config/rotate-root

![](./images/Screenshot%202024-08-24%20at%201.04.06 AM.png)


- vault read tf-vault-aws/config/root

![](./images/Screenshot%202024-08-24%20at%201.05.22 AM.png)


*Happy Learning Vault ...!!!*