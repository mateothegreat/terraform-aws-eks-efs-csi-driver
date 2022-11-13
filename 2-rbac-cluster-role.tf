resource "kubernetes_cluster_role" "efs" {

    metadata {

        name = var.name

    }

    rule {

        api_groups = [ "" ]
        resources  = [ "persistentvolumes" ]
        verbs      = [ "get", "list", "watch", "create", "delete" ]

    }

    rule {

        api_groups = [ "" ]
        resources  = [ "persistentvolumeclaims" ]
        verbs      = [ "get", "list", "watch", "update" ]

    }

    rule {

        api_groups = [ "storage.k8s.io" ]
        resources  = [ "storageclasses" ]
        verbs      = [ "list", "watch", "create" ]

    }

    rule {

        api_groups = [ "" ]
        resources  = [ "events" ]
        verbs      = [ "list", "watch", "create", "patch" ]

    }

    rule {

        api_groups = [ "storage.k8s.io" ]
        resources  = [ "csinodes" ]
        verbs      = [ "get", "list", "watch" ]

    }

    rule {

        api_groups = [ "" ]
        resources  = [ "nodes" ]
        verbs      = [ "get", "list", "watch" ]

    }

    rule {

        api_groups = [ "coordination.k8s.io" ]
        resources  = [ "leases" ]
        verbs      = [ "get", "watch", "list", "delete", "update", "create" ]

    }

}
