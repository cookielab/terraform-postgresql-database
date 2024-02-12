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
  	 access_map  = 
  	 allow_login  = 
  	 database_name  = 
  	 database_owner  = 
  	 role_name  = 
  
	 # Optional variables
  	 create_role  = false
}
```

## Resources

| Name | Type |
|------|------|
| [postgresql_default_privileges.sequences](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/default_privileges) | resource |
| [postgresql_default_privileges.tables](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/default_privileges) | resource |
| [postgresql_grant.database](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/grant) | resource |
| [postgresql_grant.schema](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/grant) | resource |
| [postgresql_grant.sequence](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/grant) | resource |
| [postgresql_grant.tables](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/grant) | resource |
| [postgresql_role.this](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/role) | resource |
| [random_password.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_map"></a> [access\_map](#input\_access\_map) | n/a | <pre>object({<br>    table_rights    = list(string)<br>    sequence_rights = list(string)<br>    schema_rights   = list(string)<br>    database_rights = list(string)<br>    }<br>  )</pre> | n/a | yes |
| <a name="input_allow_login"></a> [allow\_login](#input\_allow\_login) | n/a | `bool` | n/a | yes |
| <a name="input_create_role"></a> [create\_role](#input\_create\_role) | create role | `bool` | `false` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | database name | `string` | n/a | yes |
| <a name="input_database_owner"></a> [database\_owner](#input\_database\_owner) | database owner | `string` | n/a | yes |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | grantee user | `string` | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_password"></a> [password](#output\_password) | n/a |
| <a name="output_rolename"></a> [rolename](#output\_rolename) | n/a |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->