terraform {
  backend "s3" {
    bucket = "awis-state-359555865025"
    key    = "terraform/awis-state"
    region = "us-west-2"
  }
}
