resource "kubernetes_cluster_role_binding" "provisioner" {

    metadata {

        name = "efs-csi-provisioner-binding"

    }

    role_ref {

        api_group = "rbac.authorization.k8s.io"
        kind      = "ClusterRole"
        name      = kubernetes_cluster_role.efs.metadata[ 0 ].name

    }

    subject {

        kind      = "ServiceAccount"
        name      = kubernetes_service_account.efs.metadata[ 0 ].name
        namespace = kubernetes_service_account.efs.metadata[ 0 ].namespace

    }

}
