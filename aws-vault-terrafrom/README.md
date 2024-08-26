# aws-vault-terrafrom
- aws and vault created by terraform without using module

## Running Vault Server on Local Machine
```
vault server -dev
```
![](./images/Screenshot%202024-08-26%20at%209.19.02 PM.png)

## set the Vault Address Environment Variable

```
set the Vault Address Environment Variable
```

## If your vault is running on vagrant,

```
vault server -dev -dev-listen-address="0.0.0.0:8200"

```

![](./images/Screenshot%202024-08-26%20at%209.21.41 PM.png)

- adding rrot token 

![](./images/Screenshot%202024-08-26%20at%209.22.27 PM.png)

## check vault status

![](./images/Screenshot%202024-08-26%20at%209.29.31 PM.png)

## Verify via Vault HTTP API /sys/seal-status endpoint

```
curl http://127.0.0.1:8200/v1/sys/seal-status | jq
```
![](./images/Screenshot%202024-08-26%20at%209.31.38 PM.png)

## Verify vault auth list

![](./images/Screenshot%202024-08-26%20at%209.32.29 PM.png)


```
curl --header "X-Vault-Token:  hvs.xxxxxxxxxxxxxxxx" http://127.0.0.1:8200/v1/sys/auth | jq
```
![](./images/Screenshot%202024-08-26%20at%209.33.57 PM.png)

## vault configure

```
   export VAULT_ADDR='http://0.0.0.0:8200'
   export VAULT_TOKEN='xxxxxxxxxxx'
   
   export AWS_ACCESS_KEY_ID="xxxxxxxxxxxxx"
   export AWS_SECRET_ACCESS_KEY="xxxxx+xxxxxxx"


   
   export VAULT_ADDR='http://0.0.0.0:8202'
   export VAULT_TOKEN='xxxxxxxxxxx'

   export AWS_ACCESS_KEY_ID="xxxxxxxx"
   export AWS_SECRET_ACCESS_KEY="xxx+xxxx+xxxxxxx"

```



## Vault Deploy with Terraform

terraform init

![](./images/Screenshot%202024-08-26%20at%209.36.21 PM.png)

terraform validate

![](./images/Screenshot%202024-08-26%20at%209.37.29 PM.png)




output

```
vagrant@cloud-native-box:~/hand-on-vault/aws-vault-terrafrom$ terraform init
Initializing the backend...
Initializing provider plugins...
- Reusing previous version of hashicorp/vault from the dependency lock file
- Reusing previous version of hashicorp/aws from the dependency lock file
- Using previously-installed hashicorp/vault v4.4.0
- Using previously-installed hashicorp/aws v5.64.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
vagrant@cloud-native-box:~/hand-on-vault/aws-vault-terrafrom$ terraform plan
data.aws_iam_policy_document.master-policy: Reading...
data.aws_iam_policy_document.master-policy: Read complete after 0s [id=2331237070]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_iam_access_key.master_admin_access_key will be created
  + resource "aws_iam_access_key" "master_admin_access_key" {
      + create_date                    = (known after apply)
      + encrypted_secret               = (known after apply)
      + encrypted_ses_smtp_password_v4 = (known after apply)
      + id                             = (known after apply)
      + key_fingerprint                = (known after apply)
      + secret                         = (sensitive value)
      + ses_smtp_password_v4           = (sensitive value)
      + status                         = "Active"
      + user                           = "master-vault-admin"
    }

  # aws_iam_policy.master_user_policy will be created
  + resource "aws_iam_policy" "master_user_policy" {
      + arn              = (known after apply)
      + attachment_count = (known after apply)
      + description      = "A policy for vault-user"
      + id               = (known after apply)
      + name             = "vault-user-policy"
      + name_prefix      = (known after apply)
      + path             = "/"
      + policy           = jsonencode(
            {
              + Statement = [
                  + {
                      + Action   = [
                          + "iam:RemoveUserFromGroup",
                          + "iam:PutUserPolicy",
                          + "iam:ListUserPolicies",
                          + "iam:ListGroupsForUser",
                          + "iam:ListAttachedUserPolicies",
                          + "iam:ListAccessKeys",
                          + "iam:GetUser",
                          + "iam:DetachUserPolicy",
                          + "iam:DeleteUserPolicy",
                          + "iam:DeleteUser",
                          + "iam:DeleteAccessKey",
                          + "iam:CreateUser",
                          + "iam:CreateAccessKey",
                          + "iam:AttachUserPolicy",
                          + "iam:AddUserToGroup",
                        ]
                      + Effect   = "Allow"
                      + Resource = "arn:aws:iam::851725459960:user/*"
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + policy_id        = (known after apply)
      + tags_all         = (known after apply)
    }

  # aws_iam_policy_attachment.master-attach will be created
  + resource "aws_iam_policy_attachment" "master-attach" {
      + id         = (known after apply)
      + name       = "inline-attachment"
      + policy_arn = (known after apply)
      + users      = [
          + "master-vault-admin",
        ]
    }

  # aws_iam_user.master-user will be created
  + resource "aws_iam_user" "master-user" {
      + arn           = (known after apply)
      + force_destroy = false
      + id            = (known after apply)
      + name          = "master-vault-admin"
      + path          = "/"
      + tags_all      = (known after apply)
      + unique_id     = (known after apply)
    }

  # vault_aws_secret_backend.master-admin will be created
  + resource "vault_aws_secret_backend" "master-admin" {
      + access_key                = (sensitive value)
      + default_lease_ttl_seconds = (known after apply)
      + disable_remount           = false
      + id                        = (known after apply)
      + identity_token_ttl        = (known after apply)
      + local                     = false
      + max_lease_ttl_seconds     = (known after apply)
      + path                      = "akh-aws-master-admin"
      + region                    = (known after apply)
      + secret_key                = (sensitive value)
      + username_template         = (known after apply)
    }

Plan: 5 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + master-vault-admin-accesskey = (sensitive value)

────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
vagrant@cloud-native-box:~/hand-on-vault/aws-vault-terrafrom$ 
  Enter a value: yes

vault_aws_secret_backend.master-admin: Creating...
vault_aws_secret_backend.master-admin: Creation complete after 0s [id=akh-aws-master-admin]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

master-vault-admin-accesskey = <sensitive>


```


![](./images/Screenshot%202024-08-26%20at%2010.49.26 PM.png)

![](./images/Screenshot%202024-08-26%20at%2010.55.15 PM.png)


## add policy

![](./images/Screenshot%202024-08-26%20at%2010.49.26 PM.png)


*Happy Vault ...!!!*
