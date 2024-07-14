resource "aws_cloudwatch_log_group" "cw_agent" {
  name              = "/ecs/${local.cluster_name}/cw-agent"
  retention_in_days = 1
}

resource "aws_cloudwatch_log_group" "container_insights_perf" {
  name              = "/aws/ecs/containerinsights/${local.cluster_name}/performance"
  retention_in_days = 1
}
