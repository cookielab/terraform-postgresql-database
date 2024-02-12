<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, < 2.0.0 |
| <a name="requirement_postgresql"></a> [postgresql](#requirement\_postgresql) | ~> 1.21 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.6.0 |

Basic usage of this module is as follows:

```hcl
module "example" {
  	 source  = "<module-path>"
  
	 # Required variables
  	 roles  = 
  	 username  = 
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
| <a name="input_roles"></a> [roles](#input\_roles) | user roles | `list(string)` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | user name | `string` | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_password"></a> [password](#output\_password) | n/a |
| <a name="output_username"></a> [username](#output\_username) | n/a |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->