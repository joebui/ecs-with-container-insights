# ecs-with-container-insights

Terraform codebase to build ECS cluster with container insights enabled.

1. Enable Container Insights for your AWS - refer to <https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/deploy-container-insights-ECS-cluster.html>
2. Ensure a VPC with at least 2 subnet exist in your AWS account
3. Update default variables in `vars.tf` if needed
4. `terraform init` --> `terraform apply`
