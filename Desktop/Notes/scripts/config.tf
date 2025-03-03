terraform {
  backend "s3" {
    bucket         = "tfstate-lightops-us-east-1-891377400965"
    key            = "eks/ephemeral-6949900-167a1744/config/terraform.tfstate"
    region         = "us-east-1"
    profile        = "lightops"
    dynamodb_table = "tfstate-lightops-us-east-1-891377400965-lock"
  }

  required_providers {
    external = {
      source  = "hashicorp/external"
      version = "2.2.2"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.6.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.3.2"
    }

    time = {
      source  = "hashicorp/time"
      version = "0.8.0"
    }

    vault = {
      source  = "hashicorp/vault"
      version = "3.8.2"
    }

    http = {
      source = "hashicorp/http"
      version = "3.2.1"
    }


  }
}

provider "aws" {
  profile        = "lightops"
}


locals {
  cluster_id               = "np-t-sdfc-26119-dev-aws-ephemeral-6949900"
  cluster_id_hash          = "167a1744"
  asset_id                 = "ephemeral-6949900-167a1744"
  account_id               = "891377400965"
  environment              = "evd"
  location                 = "us-east-1"
  vault_address            = "https://vault.carbonero.eph.aks.lightops.cloud.slb-ds.com"
  oci_enabled              = false
  local_vault              = false
  vault_namespace          = "delfi-nonprod/ephemeral"
  vault_secrets_path       = "secret/apps/lightops/groups/default/clusters/${local.cluster_id}"
  lightops_override_values = {"global": {"lightops": {"enableAlertRouting": "false"}, "production": false}, "lightops-istio-controlplane": {"values": {"telemetry": {"traces": {"opentelemetry": {"randomSamplingPercentage": 100}}}}}, "workloads": {"path": "./np-t-sdfc-26119-dev-aws-ephemeral-6949900", "repoURL": "git@ssh.dev.azure.com:v3/slb-swt/delfi-delivery-infrastructure/cluster-configuration-ephemeral", "targetRevision": "master", "type": "helm"}}
  dns = {
    name        = "ephemeral-6949900"
    parent_name = "eph.aws.lightops.cloud.slb-ds.com"
  }
}

# Reference outputs from previous stage
data "terraform_remote_state" "core" {
  backend = "s3"
  config = {
    bucket         = "tfstate-lightops-us-east-1-891377400965"
    key            = "eks/ephemeral-6949900-167a1744/infra/terraform.tfstate"
    region         = "us-east-1"
    profile        = "lightops"
  }
}


# Configure Vault provider
data "external" "azure-token" {
  program = ["/bin/sh", "-c", "az account get-access-token | jq '{accessToken}'"]
}

provider "vault" {
  address = local.vault_address

  auth_login {
    namespace = local.vault_namespace
    path      = "auth/azure/login"

    parameters = {
      jwt  = data.external.azure-token.result.accessToken
      role = "global.cluster-owner"
    }
  }
}

# Configure Helm provider

provider "helm" {
  kubernetes {
    host                   = data.terraform_remote_state.core.outputs.cluster_host
    cluster_ca_certificate = base64decode(data.terraform_remote_state.core.outputs.cluster_ca_certificate)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args = ["eks", "get-token", "--cluster-name", "${local.asset_id}", "--profile", "lightops"]
    }
  }
}

# Configure kubernetes provider/*
provider "kubernetes" {
  host                   = data.terraform_remote_state.core.outputs.cluster_host
  cluster_ca_certificate = base64decode(data.terraform_remote_state.core.outputs.cluster_ca_certificate)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args = ["eks", "get-token", "--cluster-name", "${local.asset_id}", "--profile", "lightops"]
    }
}



# Create and rotate cookie secret for OAuth2 proxy

resource "time_rotating" "oauth2_proxy_cookie_secret" {
  rotation_days = 90
}

resource "random_password" "oauth2_proxy_cookie_secret" {
  length  = 32
  special = true

  depends_on = [
    time_rotating.oauth2_proxy_cookie_secret
  ]
}


# Upload OAuth2 proxy configuration as secret in "shared" vault

resource "vault_generic_secret" "oidc-credentials-configuration" {
  path = "${local.vault_secrets_path}/namespaces/oauth2-proxy/secrets/oidc-credentials"

  data_json = jsonencode({
    client-id     = data.terraform_remote_state.core.outputs.oidc_client_id
    client-secret = data.terraform_remote_state.core.outputs.oidc_client_secret
    cookie-secret = random_password.oauth2_proxy_cookie_secret.result
  })
}

# Create cluster specific dummy-secret for lightops-canary

resource "vault_generic_secret" "lightops-canary" {
  path = "${local.vault_secrets_path}/namespaces/lightops-user-journey-vault-pull-secret/secrets/canary-secret"

  data_json = jsonencode({
    dummy-secret = "dummy-value"
  })

  lifecycle {
    ignore_changes = [
      data_json
    ]
  }
}


# Deploy Argo CD configured to manage platform, stack and workloads via charts and cluster configuration repo

locals {
  lightops_standard_values = {
    "global": {
      "lightops": {
        "accountID": local.account_id,
        "targetRevision": "c0b735d7e62a873dbfe5e9c7f16d8224b885a628",
        "certManagerIssuerName": "google-public-ca-acme-prod",
        "clusterID": local.cluster_id,
        "clusterIdHash": local.cluster_id_hash,
        "asset_id" : local.asset_id,
        "containerRegistry": "975050167173.dkr.ecr.us-east-1.amazonaws.com",
        "domainName": data.terraform_remote_state.core.outputs.domain_name,
        "valueFileIds": {
          "00-platform": "values-eks.yaml"
        },
        "identities" : {
          "aws" : {
            "lightops-obs": {
              "roleArn": data.terraform_remote_state.core.outputs.lightops_obs_role
            },
            "lightops-backup": {
              "roleArn": data.terraform_remote_state.core.outputs.lightops_backup_role
            },
            "external-dns": {
              "roleArn": data.terraform_remote_state.core.outputs.external_dns_role
            },
            "cert-manager": {
              "roleArn": data.terraform_remote_state.core.outputs.cert_manager_role
            },
            "argocd": {
              "roleArn": data.terraform_remote_state.core.outputs.argocd_role
            },
            "falco": {
              "roleArn": data.terraform_remote_state.core.outputs.falco_role
            },
            "cluster-autoscaler": {
              "roleArn": data.terraform_remote_state.core.outputs.cluster_autoscaler_role
            }            
          }
        },
        "location": local.location,
        "management": {
          "manager": false, 
          "managerID": "",  
          "minion": false   
        },
        "objectStorage": {
          "loki": {
            "bucketName": data.terraform_remote_state.core.outputs.lightops_obs_loki_s3_bucket_name
          },
          "thanos": {
            "bucketName": data.terraform_remote_state.core.outputs.lightops_obs_thanos_s3_bucket_name
          },
          "tempo": {
            "bucketName": data.terraform_remote_state.core.outputs.lightops_obs_tempo_s3_bucket_name
          },
          "lightops-backup": {
            "bucketName": data.terraform_remote_state.core.outputs.lightops_backup_s3_bucket_name
          }
        },
        "vault": {
          "address": local.vault_address,
          "local": local.local_vault,
          "namespace": local.vault_namespace
        }
      },    
      "clusterID": local.cluster_id,
      "location": local.location,
      "meshSize": "x-small",
      "enableDexAuth": true,
      "domainName": data.terraform_remote_state.core.outputs.domain_name,
      "oci": {
        "enabled": local.oci_enabled
      },
      "servicePrincipals" : {},
      "environment": local.environment,
      "network": {
        "name": "ephemeral-6949900",
        "subnets": ["default"]
      },
      "targetRevision": "c0b735d7e62a873dbfe5e9c7f16d8224b885a628",
      "tenantID": "dummy",
      "vaultAddress": local.vault_address
    },
    "workloads" : {
      "path" : "./np-t-sdfc-26119-dev-aws-ephemeral-6949900"
      "repoURL" : "git@ssh.dev.azure.com:v3/slb-swt/delfi-delivery-infrastructure/cluster-configuration"
      "targetRevision" : "master"
    }
  }
}

data "vault_generic_secret" "slb-swt-repository-credentials" {
  path = "secret/global/repository-credentials/slb-swt"
}


data "external" "lightops_system" {
  program = ["jq", "{\"merged\": ((.standard | fromjson) * (.override | fromjson) | tojson)}"]

  query = {
    standard = jsonencode(local.lightops_standard_values)
    override = jsonencode(local.lightops_override_values)
  }
}

module "argo-cd" {
  source = "git::https://dev.azure.com/slb-swt/delfi-delivery-infrastructure/_git/terraform-lib//modules/k8s/argo?ref=cc1d32b5a04df1894e6dfa24ef63e854161bdacb"

  domain_name = "admin.${local.dns.name}.${local.dns.parent_name}"
  applications = {

    "lightops-system" : {
      "name" : null
      "namespace" : null
      "path" : "lightops-system"
      "repo_url" : "git@ssh.dev.azure.com:v3/slb-swt/delfi-delivery-infrastructure/lightops-charts"
      "target_revision" : "c0b735d7e62a873dbfe5e9c7f16d8224b885a628"
      "type" : "helm"
      "values" : yamlencode(jsondecode(data.external.lightops_system.result.merged))
      "valueFiles" : [
        "values-eks.yaml"
      ]
    }
  }

  ssh_private_key = data.vault_generic_secret.slb-swt-repository-credentials.data.sshPrivateKey
}




output "lightops_system_values" {
  value = yamlencode(jsondecode(data.external.lightops_system.result.merged))
}