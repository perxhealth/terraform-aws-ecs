data "aws_ecs_cluster" "ecs" {
  cluster_name = var.cluster_name
  depends_on = [aws_ecs_cluster.ecs]
}

resource "aws_ecs_cluster" "ecs" {
  count = var.create_cluster ? 1 : 0
  name  = var.cluster_name

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "aws_ecs_cluster_capacity_providers" "ecs" {
  count        = var.create_cluster ? 1 : 0
  cluster_name = aws_ecs_cluster.ecs[0].name

  capacity_providers = compact([
    try(aws_ecs_capacity_provider.ecs_capacity_provider[0].name, ""),
    "FARGATE",
    "FARGATE_SPOT"
  ])
}
