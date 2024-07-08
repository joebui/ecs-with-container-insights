# NOTE: this contains testing service. Can omit it optionally.

resource "aws_ecs_task_definition" "svc_1" {
  family                = "${local.cluster_name}-svc-1"
  container_definitions = templatefile("${path.module}/configs/nginx_svc_container_def.json", {})
}

resource "aws_ecs_service" "svc_1" {
  name                               = "${local.cluster_name}-svc-1"
  cluster                            = aws_ecs_cluster.this.id
  task_definition                    = aws_ecs_task_definition.svc_1.arn
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  desired_count                      = 2

  lifecycle {
    ignore_changes = [
      capacity_provider_strategy,
      deployment_circuit_breaker,
      deployment_controller
    ]
  }
}
