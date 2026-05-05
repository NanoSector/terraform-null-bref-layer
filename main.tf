# Validation to ensure the requested layer combinations exist
resource "null_resource" "validate_layers" {
  count = local.runtime_layer_version == null ? 1 : 0

  provisioner "local-exec" {
    command = "echo 'ERROR: One or more Bref layers not found for PHP ${var.php_version}, CPU ${var.cpu_type}, region ${var.aws_region}' && exit 1"
  }
}

# Validation to ensure all requested extensions exist
resource "null_resource" "validate_extensions" {
  count = length(var.php_extensions) > length(local.valid_extensions) ? 1 : 0

  provisioner "local-exec" {
    command = "echo 'ERROR: Some PHP extensions not found for PHP ${var.php_version}, region ${var.aws_region}. Missing: ${join(", ", setsubtract(toset(var.php_extensions), keys(local.valid_extensions)))}' && exit 1"
  }
}

# Construct the layer ARNs using the Bref naming convention
locals {
  # Bref layer ARN format: arn:aws:lambda:{region}:{account}:layer:{layer-name}:{version}
  runtime_layer_arn = local.runtime_layer_version != null ? "arn:aws:lambda:${var.aws_region}:${local.bref_layers_account_id}:layer:${local.runtime_layer_key}:${local.runtime_layer_version}" : null

  # Create combined layer arrays for each runtime type
  runtime_layers = compact(concat(
    [local.runtime_layer_arn],
    values(local.extension_arns)
  ))
}
