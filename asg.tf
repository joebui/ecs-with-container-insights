resource "aws_launch_template" "ecs" {
  name_prefix            = local.cluster_name
  image_id               = data.aws_ami.optimized_ecs.id
  vpc_security_group_ids = [data.aws_security_group.default.id]
  update_default_version = true
  key_name               = "default"
  user_data = base64encode(
    templatefile(
      "${path.module}/configs/ecs_instance_userdata.sh",
      {
        cluster = local.cluster_name
      }
    )
  )

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_type = "gp3"
    }
  }

  iam_instance_profile {
    arn = aws_iam_instance_profile.ecs_ec2.arn
  }
}

resource "aws_autoscaling_group" "ecs" {
  name                      = local.cluster_name
  desired_capacity          = 1
  desired_capacity_type     = "units"
  max_size                  = 2
  min_size                  = 1
  vpc_zone_identifier       = data.aws_subnets.public.ids
  capacity_rebalance        = true
  wait_for_capacity_timeout = "0"
  termination_policies      = ["OldestLaunchTemplate", "OldestInstance"]

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.ecs.id
        version            = aws_launch_template.ecs.latest_version
      }

      override {
        instance_type     = "t4g.small"
        weighted_capacity = "1"
      }
    }

    instances_distribution {
      spot_allocation_strategy = "price-capacity-optimized"
    }
  }

  instance_refresh {
    strategy = "Rolling"
  }

  lifecycle {
    ignore_changes = [desired_capacity]
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = local.cluster_name
    propagate_at_launch = true
  }
}
