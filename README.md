# ecs-with-container-insights

Terraform codebase to build ECS cluster with container insights enabled.

1. Enable Container Insights for your AWS - refer to <https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/deploy-container-insights-ECS-cluster.html>
2. Update vpc name and security groups for the EC2 by overriding variables in `vars.tf`
3. `terraform init` --> `terraform apply`
