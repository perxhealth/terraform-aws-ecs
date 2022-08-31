data "aws_ecs_cluster" "ecs" {
  cluster_name = var.cluster_name
}

resource "aws_ecs_cluster" "ecs" {
  count = var.create_cluster ? 1 : 0
  name  = var.cluster_name

  capacity_providers = compact([
    try(aws_ecs_capacity_provider.ecs_capacity_provider[0].name, ""),
    "FARGATE",
    "FARGATE_SPOT"
  ])

  lifecycle {
    ignore_changes = [
      tags
    ]
  }

}
