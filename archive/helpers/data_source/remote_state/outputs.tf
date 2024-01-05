#############################################################################
# OUTPUTS
#############################################################################

output "outputs" {
  value = data.terraform_remote_state.tfstate.outputs
}

output "environment" {
  value = local.environment
}

output "key" {
  value = local.key
}
