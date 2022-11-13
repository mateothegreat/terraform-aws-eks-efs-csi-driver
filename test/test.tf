provider "aws" {

    region  = "us-east-1"
    profile = "lms"


}

provider "kubernetes" {

    config_path = "~/.kube/config"

}

data "aws_eks_cluster" "cluster" {

    name = "dev-1"

}

module "test" {

    source   = "../"
    efs_id   = "fs-0059dd59d3a75addf"
    oidc_url = "https://oidc.eks.us-east-1.amazonaws.com/id/416163286F2FD97B6F1937604B423D7C"

}
