locals {
  user_data = templatefile("cloud-init.tmpl", {
    ecr_account           = var.ecr_account
    region                = var.region
    user_name             = var.user_name
    ssm_cloudwatch_config = aws_ssm_parameter.cloudwatch-agent-config.name
    cloudwatch_agent_url  = var.cloudwatch_agent_url
  })

  cw_agent_config = templatefile("amazon-cloudwatch-agent.tmpl.json", {
    app_id  = local.app_id_lower
    app_env = var.app_env
  })
}

locals {
  app_id       = "${lower(var.app_id)}-${lower(var.app_env)}"
  app_id_lower = lower(var.app_id)
  common_tags = merge(
    {
      CreateBy = "Terraform"
      Env      = var.app_env
    },
    var.tags
  )
}

locals {
  role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  ]
}
