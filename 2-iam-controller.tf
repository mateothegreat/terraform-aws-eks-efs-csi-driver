module "controller-iam" {

    source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
    version                       = "4.24.1"
    create_role                   = true
    role_description              = "EFS CSI Driver Role"
    role_name_prefix              = var.name
    provider_url                  = var.oidc_url
    role_policy_arns              = [ aws_iam_policy.efs.arn ]
    oidc_fully_qualified_subjects = [ "system:serviceaccount:${ var.namespace }:${ var.name }" ]
    tags                          = var.tags
    
}
