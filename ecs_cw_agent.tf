resource "aws_ecs_task_definition" "cwagent" {
  family                   = "${local.cluster_name}-cw-agent"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  task_role_arn            = aws_iam_role.ecs_cw_agent.arn
  execution_role_arn       = aws_iam_role.ecs_cw_agent.arn
  container_definitions = templatefile(
    "${path.module}/configs/cw_agent_container_def.json",
    {
      region       = local.aws_region
      cluster_name = local.cluster_name
    }
  )

  dynamic "volume" {
    for_each = [
      for v in local.cw_agent_volumes : {
        name      = v.Name
        host_path = v.Host.SourcePath
      }
    ]

    content {
      name      = volume.value.name
      host_path = volume.value.host_path
    }
  }
}

resource "aws_ecs_service" "cwagent" {
  name                = "${local.cluster_name}-cw-agent"
  cluster             = aws_ecs_cluster.this.id
  task_definition     = aws_ecs_task_definition.cwagent.arn
  scheduling_strategy = "DAEMON"
  launch_type         = "EC2"

  placement_constraints {
    type = "distinctInstance"
  }
}
