locals {
  cluster_name = "testing"
  aws_region   = "ap-southeast-1"
  cw_agent_volumes = jsondecode(
    templatefile("${path.module}/configs/cw_agent_volumes_mount.json", {})
  )
}
