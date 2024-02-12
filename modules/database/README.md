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
	 database_private_hostname  = 

	 # Optional variables
	 databases  = []
}
```

## Resources

| Name | Type |
|------|------|
| [postgresql_database.databases](https://registry.terraform.io/providers/cyrilgdn/postgresql/1.19.0/docs/resources/database) | resource |
| [postgresql_extension.pg_trgm](https://registry.terraform.io/providers/cyrilgdn/postgresql/1.19.0/docs/resources/extension) | resource |
| [postgresql_extension.uuid_ossp](https://registry.terraform.io/providers/cyrilgdn/postgresql/1.19.0/docs/resources/extension) | resource |
| [postgresql_role.db_roles](https://registry.terraform.io/providers/cyrilgdn/postgresql/1.19.0/docs/resources/role) | resource |
| [random_password.db_passwords](https://registry.terraform.io/providers/hashicorp/random/3.4.3/docs/resources/password) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_private_hostname"></a> [database\_private\_hostname](#input\_database\_private\_hostname) | n/a | `string` | n/a | yes |
| <a name="input_databases"></a> [databases](#input\_databases) | n/a | `list(string)` | `[]` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connection_urls"></a> [connection\_urls](#output\_connection\_urls) | n/a |
| <a name="output_database_owners"></a> [database\_owners](#output\_database\_owners) | n/a |
| <a name="output_databases"></a> [databases](#output\_databases) | n/a |
| <a name="output_passwords"></a> [passwords](#output\_passwords) | n/a |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->