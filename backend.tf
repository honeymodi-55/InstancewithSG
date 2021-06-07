terraform {
    backend "s3" {
      bucket = "honey-aws-terraform"
      key = "s3://honey-aws-terraform/honeyterraform"
      region = "ca-central-1"
    }
}