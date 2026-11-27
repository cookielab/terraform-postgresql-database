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
  	 database_name  = 
  
	 # Optional variables
  	 encoding  = "UTF8"
  	 lc_collate  = "en_US.UTF-8"
  	 lc_ctype  = "en_US.UTF-8"
  	 owner_username  = null
  	 password_wo  = null
  	 password_wo_version  = null
  	 schemas  = [
  "public"
]
  	 template  = "template0"
}
```

## Resources

| Name | Type |
|------|------|
| [postgresql_database.this](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/database) | resource |
| [postgresql_extension.pg_trgm](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/extension) | resource |
| [postgresql_extension.uuid_ossp](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/extension) | resource |
| [postgresql_role.owner](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/role) | resource |
| [postgresql_schema.this](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs/resources/schema) | resource |
| [random_password.owner](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Database name | `string` | n/a | yes |
| <a name="input_encoding"></a> [encoding](#input\_encoding) | Character set encoding of the database. Changing it replaces the database. | `string` | `"UTF8"` | no |
| <a name="input_lc_collate"></a> [lc\_collate](#input\_lc\_collate) | Collation order (LC\_COLLATE) of the database. Changing it replaces the database. | `string` | `"en_US.UTF-8"` | no |
| <a name="input_lc_ctype"></a> [lc\_ctype](#input\_lc\_ctype) | Character classification (LC\_CTYPE) of the database. Changing it replaces the database. | `string` | `"en_US.UTF-8"` | no |
| <a name="input_owner_username"></a> [owner\_username](#input\_owner\_username) | Database owner role name, defaults to `<database_name>_migrator` | `string` | `null` | no |
| <a name="input_password_wo"></a> [password\_wo](#input\_password\_wo) | Write-only owner password, used together with `password_wo_version`. It is not stored in state, the `password` output is null then. | `string` | `null` | no |
| <a name="input_password_wo_version"></a> [password\_wo\_version](#input\_password\_wo\_version) | Version of the write-only owner password. Setting it switches the owner role to `password_wo`; change it to write a new password. Null keeps the generated password stored in state. | `string` | `null` | no |
| <a name="input_schemas"></a> [schemas](#input\_schemas) | Schemas of the database. Every schema except `public` (which exists in every database) is created and owned by the owner role. | `list(string)` | <pre>[<br/>  "public"<br/>]</pre> | no |
| <a name="input_template"></a> [template](#input\_template) | Template database the database is created from. Changing it replaces the database. | `string` | `"template0"` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_name"></a> [database\_name](#output\_database\_name) | Database name |
| <a name="output_password"></a> [password](#output\_password) | Owner role password, null when a write-only password is used |
| <a name="output_schemas"></a> [schemas](#output\_schemas) | Map of schema names, values reference the created schemas so that grants depend on them |
| <a name="output_username"></a> [username](#output\_username) | Owner role name |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->