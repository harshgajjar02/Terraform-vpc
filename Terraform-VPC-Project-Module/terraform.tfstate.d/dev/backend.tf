terraform {
  backend "s3" {
    bucket = "<Enter Your Bucket Name>"
    key    = "<Bucket inside subkey>"
    region = "<region>"
    dynamodb_table = "<dynamodb table name>"
  }
}