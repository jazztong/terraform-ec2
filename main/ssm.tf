# Cloudwatch agent config
resource "aws_ssm_parameter" "cloudwatch-agent-config" {
  name  = "/${local.app_id_lower}/${var.app_env}/cloudwatch-agent/config"
  type  = "String"
  value = local.cw_agent_config

  tags = merge({ Name = "${local.app_id}-ssm" }, local.common_tags)
}
