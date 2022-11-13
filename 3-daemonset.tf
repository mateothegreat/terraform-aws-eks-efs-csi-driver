resource "kubernetes_daemonset" "efs" {

    metadata {

        name      = var.name
        namespace = var.namespace

        labels = {

            app = var.name

        }

    }

    spec {

        selector {

            match_labels = {

                app = var.name

            }

        }

        template {

            metadata {

                labels = {

                    app = var.name

                }

            }

            spec {

                host_network        = true
                priority_class_name = "system-node-critical"

                node_selector = {

                    "beta.kubernetes.io/os" : "linux",

                }

                toleration {

                    operator = "Exists"

                }

                container {

                    name              = "efs-plugin"
                    image             = "amazon/aws-efs-csi-driver:v1.4.5"
                    image_pull_policy = "IfNotPresent"

                    args = [ "-endpoint=$(CSI_ENDPOINT)", "-v=1" ]

                    env {

                        name  = "CSI_ENDPOINT"
                        value = "unix:/csi/csi.sock"

                    }

                    volume_mount {

                        mount_path        = "/var/lib/kubelet"
                        name              = "kubelet-dir"
                        mount_propagation = "Bidirectional"

                    }

                    volume_mount {

                        mount_path = "/csi"
                        name       = "plugin-dir"

                    }

                    volume_mount {

                        mount_path = "/var/run/efs"
                        name       = "efs-state-dir"

                    }

                    volume_mount {

                        mount_path = "/etc/amazon/efs"
                        name       = "efs-utils-config"

                    }

                    port {

                        name           = "healthz"
                        container_port = 9809
                        protocol       = "TCP"

                    }

                    liveness_probe {

                        http_get {

                            path = "/healthz"
                            port = "healthz"

                        }

                        initial_delay_seconds = 10
                        timeout_seconds       = 3
                        period_seconds        = 10
                        failure_threshold     = 5
                        
                    }

                    readiness_probe {

                        http_get {

                            path = "/healthz"
                            port = "healthz"

                        }

                        initial_delay_seconds = 10
                        timeout_seconds       = 3
                        period_seconds        = 2
                        failure_threshold     = 5

                    }

                    security_context {

                        privileged = true

                    }

                }

                container {

                    name  = "csi-driver-registrar"
                    image = "public.ecr.aws/eks-distro/kubernetes-csi/node-driver-registrar:v2.1.0-eks-1-18-13"
                    args  = [ "-csi-address=$(ADDRESS)", "-kubelet-registration-path=$(DRIVER_REG_SOCK_PATH)", "-v=1" ]

                    env {

                        name  = "ADDRESS"
                        value = "/csi/csi.sock"

                    }

                    env {

                        name  = "DRIVER_REG_SOCK_PATH"
                        value = "/var/lib/kubelet/plugins/efs.csi.aws.com/csi.sock"

                    }

                    env {

                        name = "KUBE_NODE_NAME"

                        value_from {

                            field_ref {

                                field_path = "spec.nodeName"

                            }

                        }

                    }

                    volume_mount {

                        mount_path = "/csi"
                        name       = "plugin-dir"

                    }

                    volume_mount {

                        mount_path = "/registration"
                        name       = "registration-dir"

                    }

                }

                container {

                    name  = "liveness-probe"
                    image = "public.ecr.aws/eks-distro/kubernetes-csi/livenessprobe:v2.2.0-eks-1-18-13"
                    args  = [ "-csi-address=/csi/csi.sock", "-health-port=9809" ]

                    volume_mount {

                        mount_path = "/csi"
                        name       = "plugin-dir"

                    }

                }

                volume {

                    name = "kubelet-dir"

                    host_path {

                        path = "/var/lib/kubelet"
                        type = "Directory"

                    }

                }

                volume {

                    name = "plugin-dir"

                    host_path {

                        path = "/var/lib/kubelet/plugins/efs.csi.aws.com/"
                        type = "DirectoryOrCreate"

                    }

                }

                volume {

                    name = "registration-dir"

                    host_path {

                        path = "/var/lib/kubelet/plugins_registry/"
                        type = "Directory"

                    }

                }

                volume {

                    name = "efs-state-dir"

                    host_path {

                        path = "/var/run/efs"
                        type = "DirectoryOrCreate"

                    }

                }

                volume {

                    name = "efs-utils-config"

                    host_path {

                        path = "/etc/amazon/efs"
                        type = "DirectoryOrCreate"

                    }

                }

            }

        }

    }

}
