output "awis_access_key" {
   value  = "${aws_iam_access_key.awis-user.id}"
}

output "awis_secret_key" {
  value = "${aws_iam_access_key.awis-user.secret}"
}
