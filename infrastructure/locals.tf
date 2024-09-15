locals {
  tags = {
    Owner       = "jorge-trivilin"
    Project     = "mlops-v2"
    Environment = "${var.environment}"
    Toolkit     = "terraform"
    Name        = "${var.prefix}"
  }
}