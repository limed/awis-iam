output "awis_access_key" {
  value = "${aws_iam_access_key.awis-user.id}"
}

output "awis_secret_key" {
  value = "${aws_iam_access_key.awis-user.secret}"
}

output "bucket_iam_user" {
  value = "${aws_iam_user.user.*.name}"
}

output "bucket_iam_access_key" {
  value = "${aws_iam_access_key.keys.*.id}"
}

output "bucket_iam_secret_key" {
  value = "${aws_iam_access_key.keys.*.secret}"
}

output "environments" {
  value = "${local.environments}"
}
