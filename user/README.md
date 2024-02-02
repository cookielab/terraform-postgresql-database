<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0, < 2.0.0 |
| <a name="requirement_postgresql"></a> [postgresql](#requirement\_postgresql) | 1.19.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |

Basic usage of this module is as follows:

```hcl
module "example" {
	 source  = "<module-path>"

	 # Required variables
	 access_map  = 
	 access_user  = 
	 db_name  = 
	 db_owner  = 
}
```

## Resources

| Name | Type |
|------|------|
| [postgresql_default_privileges.sequences](https://registry.terraform.io/providers/cyrilgdn/postgresql/1.19.0/docs/resources/default_privileges) | resource |
| [postgresql_default_privileges.tables](https://registry.terraform.io/providers/cyrilgdn/postgresql/1.19.0/docs/resources/default_privileges) | resource |
| [postgresql_grant.database](https://registry.terraform.io/providers/cyrilgdn/postgresql/1.19.0/docs/resources/grant) | resource |
| [postgresql_grant.schema](https://registry.terraform.io/providers/cyrilgdn/postgresql/1.19.0/docs/resources/grant) | resource |
| [postgresql_grant.sequence](https://registry.terraform.io/providers/cyrilgdn/postgresql/1.19.0/docs/resources/grant) | resource |
| [postgresql_grant.tables](https://registry.terraform.io/providers/cyrilgdn/postgresql/1.19.0/docs/resources/grant) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_map"></a> [access\_map](#input\_access\_map) | n/a | <pre>object({<br>    table_rights    = list(string)<br>    sequence_rights = list(string)<br>    schema_rights   = list(string)<br>    database_rights = list(string)<br>    }<br>  )</pre> | n/a | yes |
| <a name="input_access_user"></a> [access\_user](#input\_access\_user) | grantee user | `string` | n/a | yes |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | database name | `string` | n/a | yes |
| <a name="input_db_owner"></a> [db\_owner](#input\_db\_owner) | database owner | `string` | n/a | yes |
## Outputs

No outputs.
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->