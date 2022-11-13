resource "kubernetes_service_account" "efs" {

    metadata {

        name      = var.name
        namespace = var.namespace

        annotations = {

            "eks.amazonaws.com/role-arn" = module.controller-iam.iam_role_arn

        }

    }

    automount_service_account_token = true

}
