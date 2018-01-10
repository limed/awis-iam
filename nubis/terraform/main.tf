provider "aws" {
  version = "~> 0.1"
  region  = "${var.region}"
}

resource "aws_iam_user" "awis-user" {
  name  = "${var.awis-user}"
}

resource "aws_iam_access_key" "awis-user" {
  user  = "${aws_iam_user.awis-user.name}"
}

resource "aws_iam_user_policy" "awis-query" {
  name = "awis_query"
  user = "${aws_iam_user.awis-user.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
				"awis:GET",
        "AlexaTopSites:GET"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
