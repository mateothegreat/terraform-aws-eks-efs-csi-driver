resource "kubernetes_csi_driver_v1" "efs" {

    metadata {

        name = var.name

        labels = {

            "app.kubernetes.io/name" = var.name

        }

    }

    spec {

        attach_required = true

        volume_lifecycle_modes = [ "Ephemeral" ]

    }

}
