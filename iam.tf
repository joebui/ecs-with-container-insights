resource "aws_iam_role" "ecs_ec2" {
  name               = "${local.cluster_name}-ecs-ec2"
  assume_role_policy = templatefile("${path.module}/policies/ec2_assume_role.json", {})
}

resource "aws_iam_role_policy_attachment" "ecs_ec2" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  role       = aws_iam_role.ecs_ec2.name
}

resource "aws_iam_instance_profile" "ecs_ec2" {
  name = local.cluster_name
  role = aws_iam_role.ecs_ec2.name
}

resource "aws_iam_role" "ecs_cw_agent" {
  name               = "${local.cluster_name}-ecs-task"
  assume_role_policy = templatefile("${path.module}/policies/ecs_task_assume_role.json", {})
}

resource "aws_iam_role_policy_attachment" "ecs_cw_agent_exec_role" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role       = aws_iam_role.ecs_cw_agent.name
}

resource "aws_iam_role_policy_attachment" "ecs_cw_agent_server_policy" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = aws_iam_role.ecs_cw_agent.name
}
