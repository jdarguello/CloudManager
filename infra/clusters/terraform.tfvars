clusters = [
  {
    cluster_name = "Manager-Cluster"
    cluster_config = {
      node_pools    = ["general-purpose"]
      instance_type = ["m6i.large"]
      min_size      = 1
      max_size      = 2
      desired_size  = 1
      tags = {
        Environment = "dev"
        Terraform   = "true"
        Name        = "Manager-Cluster"
      }
    }
    vpc = {
      name = "Manager-VPC"
      cidr = "10.0.0.0/16"
      tags = {
        Name       = "Manager-VPC"
        CostCenter = "Grupo Cibest"
      }
    }
  }
]