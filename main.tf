#resource for creating an independent Instance
resource "aws_instance" "First_Instance" {
  name = "InstancewithSG"
  description = "An Instance built using Terrafrom"
  ami = "ami-0277fbe7afa8a33a6"
  instance_type = "t2.micro"
  key_name = "trail-key"
  tags = {
      Name = "terraform-honey"
      }
}


#resource for creating an independent security group
# resource "aws_security_group" "SG_Honey" {
#  name = "SG_Honey"
#  ingress {
#     cidr_blocks = [ "99.227.118.13/32" ]
#     from_port = 8080
#     to_port = 8080
#     protocol = "tcp"
#   } 

#   egress {
#     cidr_blocks = [ "0.0.0.0/0" ]
#     from_port = 0
#     to_port = 0
#     protocol = "-1"
#   }

#   tags = {
#     Name = "terraform-honey"
#   }  
# }

#resource for creating a Storage S3 Bucket
resource "aws_s3_bucket" "Bucket1" {
  bucket = "honeys-terraform-bucket"
  acl = "private"

  tags = {
    Name = "terraform-honey"
  }

  versioning {
    enabled = true
  }
}

provider "aws" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

#create a new instance and a security group and attcah both of them  
#create a storage bucket (tags) add tags to all rseouce : key:name value:terraform-honey