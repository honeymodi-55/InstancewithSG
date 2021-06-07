terraform {
    backend "s3" {
      bucket = "honey-aws-terraform"
      key = "terraformkey"
      region = "ca-central-1"
    }
}