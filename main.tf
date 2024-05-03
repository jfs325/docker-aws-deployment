resource "aws_ecs_cluster" "cluster" {
  name = "week20_ecs_cluster"

#   capacity_providers = ["FARGATE_SPOT", "FARGATE"]

#   default_capacity_provider_strategy {
#     capacity_provider = "FARGATE_SPOT"
#   }

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

resource "aws_ecs_cluster_capacity_providers" "example" {
  cluster_name = aws_ecs_cluster.cluster.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}

module "ecs-fargate" {
  source  = "umotif-public/ecs-fargate/aws"
  version = "~> 6.1.0"

  name_prefix        = "ecs-fargate-example"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.public_subnets

  cluster_id = aws_ecs_cluster.cluster.id

  task_container_image   = "public.ecr.aws/o2u9j5x1/service-deploy:latest"
  task_definition_cpu    = 256
  task_definition_memory = 512

  task_container_port             = 8000
  task_container_assign_public_ip = true

  load_balanced = false

  target_groups = [
    {
      target_group_name = "tg-fargate-example"
      container_port    = 8000
    }
  ]

  health_check = {
    port = "traffic-port"
    path = "/"
  }

  tags = {
    Environment = "test"
    Project     = "Test"
  }
}