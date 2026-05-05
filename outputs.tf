output "runtime_layer_arn" {
  description = "ARN of the Bref PHP runtime layer"
  value       = local.runtime_layer_arn
}

# PHP Extensions outputs
output "extension_layer_arns" {
  description = "Map of PHP extension names to their layer ARNs"
  value       = local.extension_arns
}

# Combined layer arrays for each runtime type
output "runtime_layers" {
  description = "Array containing the runtime layer ARN and all extension layer ARNs"
  value       = local.runtime_layers
}

# Additional useful outputs
output "php_version" {
  description = "PHP version used for the layers"
  value       = var.php_version
}

output "cpu_type" {
  description = "CPU architecture type used for the layers"
  value       = var.cpu_type
}

output "region" {
  description = "AWS region where the layers are located"
  value       = var.aws_region
}

output "php_extensions" {
  description = "List of PHP extensions included"
  value       = var.php_extensions
}

output "layer_versions" {
  description = "Version numbers of the layers"
  value = {
    runtime = local.runtime_layer_version
    extensions = {
      for ext, data in local.valid_extensions : ext => data.version
    }
  }
}
