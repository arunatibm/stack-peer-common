# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "prefix" {
  type = string
}

required_providers {
  random = {
    source  = "hashicorp/random"
    version = "~> 3.5.1"
  }
}

provider "random" "this" {}

component "app-payment" {
  source = "../comp-payment"

  inputs = {
    prefix = var.prefix
  }

  providers = {
    random = provider.random.this
  }
}

output "billing-payment" {
  description = "Payment component for the billing service of the online store"
  type = string
  value = component.app-payment.name
  sensitive = false
  ephemeral = false
}