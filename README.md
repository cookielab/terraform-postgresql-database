<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0, < 2.0.0 |

Basic usage of this module is as follows:

```hcl
module "example" {
  	 source  = "<module-path>"
  
	 # Required variables
  	 database_private_hostname  = 
  	 databases  = 
  	 user_role  = 
  
	 # Optional variables
  	 create_access_user  = false
}
```

## Resources

No resources.
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_access_user"></a> [create\_access\_user](#input\_create\_access\_user) | Create access user | `bool` | `false` | no |
| <a name="input_database_private_hostname"></a> [database\_private\_hostname](#input\_database\_private\_hostname) | Hostname used in connection\_url output | `string` | n/a | yes |
| <a name="input_databases"></a> [databases](#input\_databases) | databases object: { ACCESS\_USER = { database = "DBNAME" roles = [ "ROLE1"] } … } | <pre>map(object({<br>    database = string<br>    roles = list(string)<br>  }))</pre> | n/a | yes |
| <a name="input_user_role"></a> [user\_role](#input\_user\_role) | users object: { "USERNAME" = { "roles" = [ "ROLE1", … ] } … } | <pre>map(object({<br>    roles = list(string)<br>  }))</pre> | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connection_url"></a> [connection\_url](#output\_connection\_url) | Object returning connection strings |
| <a name="output_database_name"></a> [database\_name](#output\_database\_name) | Object returning database names |
| <a name="output_database_owner"></a> [database\_owner](#output\_database\_owner) | Object returning database owners and their credentials |
| <a name="output_password"></a> [password](#output\_password) | Object returning usersnames and their passwords |
| <a name="output_username"></a> [username](#output\_username) | Object returning usersnames |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->