<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0, < 2.0.0 |
| <a name="requirement_postgresql"></a> [postgresql](#requirement\_postgresql) | ~> 1.21 |

Basic usage of this module is as follows:

```hcl
module "example" {
  	 source  = "<module-path>"
  
	 # Required variables
  	 database  = 
  
	 # Optional variables
  	 app_username  = null
  	 create_role_ro  = true
  	 create_role_rw  = true
  	 encoding  = "UTF8"
  	 lc_collate  = "en_US.UTF-8"
  	 lc_ctype  = "en_US.UTF-8"
  	 owner_username  = null
  	 role_ro_name  = null
  	 role_rw_name  = null
  	 template  = "template0"
}
```

## Resources

No resources.
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_username"></a> [app\_username](#input\_app\_username) | Application username | `string` | `null` | no |
| <a name="input_create_role_ro"></a> [create\_role\_ro](#input\_create\_role\_ro) | Toggle read-only role creation | `bool` | `true` | no |
| <a name="input_create_role_rw"></a> [create\_role\_rw](#input\_create\_role\_rw) | Toggle read-write role creation | `bool` | `true` | no |
| <a name="input_database"></a> [database](#input\_database) | Database name | `string` | n/a | yes |
| <a name="input_encoding"></a> [encoding](#input\_encoding) | Character set encoding of the database. Changing it replaces the database. | `string` | `"UTF8"` | no |
| <a name="input_lc_collate"></a> [lc\_collate](#input\_lc\_collate) | Collation order (LC\_COLLATE) of the database. Changing it replaces the database. | `string` | `"en_US.UTF-8"` | no |
| <a name="input_lc_ctype"></a> [lc\_ctype](#input\_lc\_ctype) | Character classification (LC\_CTYPE) of the database. Changing it replaces the database. | `string` | `"en_US.UTF-8"` | no |
| <a name="input_owner_username"></a> [owner\_username](#input\_owner\_username) | Database owner | `string` | `null` | no |
| <a name="input_role_ro_name"></a> [role\_ro\_name](#input\_role\_ro\_name) | Read-only role name | `string` | `null` | no |
| <a name="input_role_rw_name"></a> [role\_rw\_name](#input\_role\_rw\_name) | Read-write role name | `string` | `null` | no |
| <a name="input_template"></a> [template](#input\_template) | Template database the database is created from. Changing it replaces the database. | `string` | `"template0"` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_user"></a> [app\_user](#output\_app\_user) | Object returning application user and its credentials |
| <a name="output_database_name"></a> [database\_name](#output\_database\_name) | Object returning database names |
| <a name="output_owner_user"></a> [owner\_user](#output\_owner\_user) | Object returning database owner and its credentials |
| <a name="output_roles"></a> [roles](#output\_roles) | List of additional roles having permission on the database |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->