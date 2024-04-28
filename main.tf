# Configure the AWS provider
provider "aws" {
  region = "eu-central-1"
}

# Create a Virtual Private Cloud (VPC)
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Create subnets in different Availability Zones within the VPC
resource "aws_subnet" "subnet_a" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-central-1a"
}

resource "aws_subnet" "subnet_b" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-central-1b"
}

# Create an Amazon Elastic Kubernetes Service (EKS) cluster
resource "aws_eks_cluster" "my_cluster" {
  name     = "my-eks-cluster"
  role_arn = "arn:aws:iam::654654195772:role/aws-learning-eks-cluster-role"

  vpc_config {
    subnet_ids = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
  }
}

# # Deploy the Dockerized Node.js application using a Kubernetes Deployment
# resource "kubernetes_deployment" "app" {
#   depends_on = [aws_eks_cluster.my_cluster]
#   metadata {
#     name = "app-deployment"
#   }

#   spec {
#     replicas = 1

#     selector {
#       match_labels = {
#         app = "app"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = "app"
#         }
#       }

#       spec {
#         container {
#           name  = "app"
#           image = "jagostinho900/app:latest"
#           port {
#             container_port = 3000
#           }
#         }
#       }
#     }
#   }
# }

# # Expose the Node.js application to the internet using a Kubernetes Service
# resource "kubernetes_service" "app_service" {
#   metadata {
#     name = "app-service"
#   }

#   spec {
#     selector = {
#       app = "app"
#     }

#     port {
#       protocol    = "TCP"
#       port        = 80
#       target_port = 3000
#     }

#     type = "LoadBalancer"
#   }
# }
