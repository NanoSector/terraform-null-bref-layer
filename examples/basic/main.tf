# Basic example usage of the Bref Lambda Layers module (without extensions)

# Test with default values (PHP 8.4, x86)
module "test_default" {
  source = "../../"

  aws_region = "us-east-1"
}

# Test with custom values (PHP 8.3, ARM64)
module "test_custom" {
  source = "../../"

  php_version = "83"
  cpu_type    = "arm64"
  aws_region  = "us-west-2"
}

# Output the results for validation
output "test_default_results" {
  value = {
    runtime_layer_arn = module.test_with_extensions.runtime_layer_arn
    versions          = module.test_with_extensions.layer_versions
    extensions        = module.test_with_extensions.extension_layer_arns
    runtime_layers    = module.test_with_extensions.runtime_layers
  }
}

output "test_custom_results" {
  value = {
    runtime_layer_arn = module.test_with_extensions.runtime_layer_arn
    versions          = module.test_with_extensions.layer_versions
    extensions        = module.test_with_extensions.extension_layer_arns
    runtime_layers    = module.test_with_extensions.runtime_layers
  }
}
