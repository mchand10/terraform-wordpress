terraform {
  backend "s3" {
    bucket         = "terraformwordpress"
    key            = "terraform.tfstate"
    region         = "us-east-1"
  }
}

provider "aws" { 
    region = "${var.AWS_REGION}"
}
