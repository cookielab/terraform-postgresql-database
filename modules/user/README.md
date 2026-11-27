<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.11.0, < 2.0.0 |
| <a name="requirement_postgresql"></a> [postgresql](#requirement\_postgresql) | ~> 1.26 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.6.0 |

Basic usage of this module is as follows:

```hcl
module "example" {
  	 source  = "<module-path>"
  
	 # Required variables
  	 roles  = 
  	 username  = 
  
	 # Optional variables
  	 password_wo  = null
  	 password_wo_version  = null
}
```

## Resources

| Name | Type |
|------|------|
| [postgresql_grant_role.roles](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/grant_role) | resource |
| [postgresql_role.this](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/role) | resource |
| [random_password.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_password_wo"></a> [password\_wo](#input\_password\_wo) | Write-only password of the user, used together with `password_wo_version`. It is not stored in state, the `password` output is null then. | `string` | `null` | no |
| <a name="input_password_wo_version"></a> [password\_wo\_version](#input\_password\_wo\_version) | Version of the write-only user password. Setting it switches the role to `password_wo`; change it to write a new password. Null keeps the generated password stored in state. | `string` | `null` | no |
| <a name="input_roles"></a> [roles](#input\_roles) | user roles | `list(string)` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | user name | `string` | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_password"></a> [password](#output\_password) | User password, null when a write-only password is used |
| <a name="output_username"></a> [username](#output\_username) | User name |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->