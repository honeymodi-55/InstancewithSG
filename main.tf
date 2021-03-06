#resource for creating an independent Instance
resource "aws_instance" "First_Instance" {
  ami = "ami-0277fbe7afa8a33a6"
  instance_type = "t2.micro"
  key_name = "trail-key"
  tags = {
      Name = "terraform-honey"
      }
}

#resource for creating a new Instance
resource "aws_instance" "apache_instance" {
  ami = "ami-0277fbe7afa8a33a6"
  instance_type = "t2.micro"
  key_name = "trail-key"
  security_groups = [ "${aws_security_group.SG_Honey.name}" ]
  tags = {
      Name = "apache"
      }
}

#resource for creating an independent security group
resource "aws_security_group" "SG_Honey" {
 name = "SG_Honey"  

 ingress {
    cidr_blocks = [ "99.227.118.13/32" ]
    from_port = 8080
    to_port = 8080
    protocol = "tcp"  
  } 

  egress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }

  tags = {
    Name = "terraform-honey"
  }  
}

resource "aws_security_group_rule" "port_22_rule" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = "sg-04467a714596c39ed" #source security group
  security_group_id = aws_security_group.SG_Honey.id  #destiantion
}

resource "aws_security_group_rule" "port_80_rule" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks = ["99.227.118.13/32"]
  security_group_id = aws_security_group.SG_Honey.id  #destiantion
}

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

#creating a connection between the security group and instance
resource "aws_network_interface_sg_attachment" "ConnectiontoSG" {
  security_group_id = aws_security_group.SG_Honey.id
  network_interface_id = aws_instance.First_Instance.primary_network_interface_id
}

  provider "aws" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

#create a new instance and a security group and attcah both of them  
#create a storage bucket (tags) add tags to all rseouce : key:name value:terraform-honey
