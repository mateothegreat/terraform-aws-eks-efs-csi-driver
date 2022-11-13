variable "name" {

    type        = string
    default     = "csi-efs"
    description = "Name of the EFS CSI driver resources."

}

variable "namespace" {

    type        = string
    default     = "kube-system"
    description = "Namespace of the EFS CSI driver resources."

}

variable "oidc_url" {

    type        = string
    description = "OIDC URL of the EKS cluster."

}

variable "tags" {

    type        = map(string)
    description = "Tags to apply to the EFS CSI driver resources."
    default     = {}

}

variable "efs_id" {

    type        = string
    description = "ID of the EFS file system."

}
