locals {
  log_group_creates = [
    "ec2/UserDataLog",
    "ec2/CloudWatchAgentLog",
    "ec2/var/log/messages",
    "ec2/var/log/secure",
    "ec2/var/log/yum"
  ]
}

resource "aws_cloudwatch_log_group" "log_group" {
  count = length(local.log_group_creates)

  retention_in_days = 30
  name              = "/${local.app_id_lower}/${var.app_env}/${local.log_group_creates[count.index]}"

  tags = merge({ Name = "${local.app_id}-log-group" }, local.common_tags)
}
