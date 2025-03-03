# maintenance window 

provider "aws" {
    profile = "default"
    region = "us-east-1"
}

data "aws_iam_policy_document" "eks_mt_window_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ssm.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "mt_window_role" {
  name = "mt-window-role"
  assume_role_policy = data.aws_iam_policy_document.eks_mt_window_role.json
}

resource "aws_iam_role_policy_attachment" "test_attach" {
  role       = aws_iam_role.mt_window_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}



resource "aws_ssm_activation" "foo" {
  name               = "test_ssm_activation"
  description        = "Test"
  iam_role           = aws_iam_role.mt_window_role.id
  registration_limit = "5"
  depends_on         = [aws_iam_role_policy_attachment.test_attach]
}

resource "aws_ssm_maintenance_window" "production" {
  name     = "eks-ephemeral-7473008-d7a2ea3c-mt-window"
  schedule = "rate(30 days)"
  duration = 3
  cutoff   = 1
  allow_unassociated_targets = true
  enabled = true
  start_date   = "2024-10-01T00:30:00Z"  # Start date in UTC
  schedule_timezone = "UTC"
}

resource "aws_ssm_maintenance_window_target" "target1" {
  window_id     = aws_ssm_maintenance_window.production.id
  name          = "maintenance-window-target"
  description   = "This is a maintenance window target"
  resource_type = "INSTANCE"

  targets {
    key    = "tag:slb.com/cluster"
    values = ["ephemeral-7473008-d7a2ea3c"]
  }
}

resource "aws_ssm_maintenance_window_task" "update_eks_nodegroup_version" {
  name = "Upgrade-AMI"
  description = "updates the nodegroup version"
  priority        = 1
  task_arn        = "AWS-UpdateEKSManagedNodegroupVersion"
  task_type       = "AUTOMATION"
  window_id       = aws_ssm_maintenance_window.production.id

  cutoff_behavior = "CANCEL_TASK" # Prevent new task invocations from starting when the maintenance window cutoff time is reached.
  
  service_role_arn = aws_iam_role.mt_window_role.arn

  targets {
    key    = "WindowTargetIds"
    values = [aws_ssm_maintenance_window_target.target1.id]
  }

  task_invocation_parameters {
    automation_parameters {
      document_version = "$LATEST"
      parameter {
        name   = "ClusterName"
        values = ["ephemeral-7473008-ccf8a645"]  # Replace with your actual EKS cluster name
      }
      parameter {
        name = "NodeGroupName"
        values = ["nodepool1"]
      }
    #   parameter {
    #     name   = "NodegroupName"
    #     values = ["nodepool1"] # Replace with your actual node group name
    #   }
      parameter {
        name   = "ForceUpgrade"
        values = ["[\"\"]"]  # Optional: Whether to force the update
      }
    }
  }
}
