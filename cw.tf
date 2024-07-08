resource "aws_cloudwatch_log_group" "cw_agent" {
  name              = "/ecs/${local.cluster_name}-cw-agent"
  retention_in_days = 1
}
