data "aws_iam_policy_document" "efs" {

    statement {

        effect    = "Allow"
        resources = [ "*" ]
        actions   = [ "elasticfilesystem:DescribeAccessPoints", "elasticfilesystem:DescribeFileSystems" ]

    }

    statement {

        effect    = "Allow"
        resources = [ "*" ]
        actions   = [ "elasticfilesystem:CreateAccessPoint" ]

        condition {

            test     = "StringLike"
            variable = "aws:RequestTag/efs.csi.aws.com/cluster"
            values   = [ "true" ]

        }

    }

    statement {

        effect    = "Allow"
        resources = [ "*" ]
        actions   = [ "elasticfilesystem:DeleteAccessPoint" ]

        condition {

            test     = "StringLike"
            variable = "aws:ResourceTag/efs.csi.aws.com/cluster"
            values   = [ "true" ]

        }

    }

}

resource "aws_iam_policy" "efs" {

    name_prefix = var.name
    policy      = data.aws_iam_policy_document.efs.json
    tags        = var.tags

}
