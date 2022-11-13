resource "kubernetes_storage_class_v1" "efs" {

    storage_provisioner = "efs.csi.aws.com"

    metadata {

        name = var.name

    }

    parameters = {

        fileSystemId     = var.efs_id
        provisioningMode = "efs-ap"
        directoryPerms   = "770"
        directoryPath    = "/data"

    }

}
