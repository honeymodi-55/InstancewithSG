terraform {
    backend "s3" {
      bucket = "honey-aws-terraform"
      key = "honeyterraform"
      region = "ca-central-1"
    }
}