provider "kubernetes" {

  #   region = "us-east-2"
  #   load_config_file       = "false"
  host                   = data.aws_eks_cluster.my-app-cluster.endpoint
  token                  = data.aws_eks_cluster_auth.my-app-cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.my-app-cluster.certificate_authority.0.data)


}

data "aws_eks_cluster" "my-app-cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "my-app-cluster" {
  name = module.eks.cluster_id
}

# module "eks" {
#   source  = "terraform-aws-modules/eks/aws"
#   version = "19.13.0"

#   #insert the 7 required params 

#   cluster_name    = "my-app-eks-cluster"
#   cluster_version = "1.17"
#   # [] of private subnet ids 
#   #   subnets = module.vpc.private_subnets

#   tags = {
#     environment = "development"
#     application = "myapp"
#   }

#   vpc_id = module.vpc.vpc_id

#   #   worker_groups = [
#   #     {
#   #       instance_type        = "t2.small"
#   #       name                 = "worker-group-1"
#   #       asg_desired_capacity = 2
#   #     },
#   #     {
#   #       instance_type        = "t2.medium"
#   #       name                 = "worker-group-2"
#   #       asg_desired_capacity = 1
#   #     }
#   #   ]
# }
