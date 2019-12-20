provider "aws" {
  version = "~> 2"
  region  = "${var.region}"
}

resource "aws_iam_user" "awis-user" {
  name = "${var.awis-user}"
}

resource "aws_iam_access_key" "awis-user" {
  user = "${aws_iam_user.awis-user.name}"
}

resource "aws_iam_user_policy" "awis-query" {
  name   = "awis_query"
  user   = "${aws_iam_user.awis-user.name}"
  policy = "${data.aws_iam_policy_document.alexa.json}"
}

data "aws_iam_policy_document" "alexa" {
  statement {
    effect = "Allow"

    actions = [
      "awis:GET",
      "AlexaTopSites:GET",
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "bucket" {
  count = "${length(local.environments)}"

  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::${local.bucket_names[count.index]}",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::${local.bucket_names[count.index]}/*",
    ]
  }
}

locals {
  environments = ["stage", "prod"]
  bucket_names = ["webcompat-stage", "webcompat"]
}

resource "aws_iam_policy" "policy" {
  count  = "${length(local.environments)}"
  name   = "${local.bucket_names[count.index]}-iam-policy"
  policy = "${element(data.aws_iam_policy_document.bucket.*.json, count.index)}"
}

resource "aws_iam_user_policy_attachment" "attachment" {
  count      = "${length(local.environments)}"
  user       = "${aws_iam_user.awis-user.name}"
  policy_arn = "${element(aws_iam_policy.policy.*.arn, count.index)}"
}

resource "aws_s3_bucket" "this" {
  count  = "${length(local.environments)}"
  bucket = "${local.bucket_names[count.index]}"

  tags {
    Name        = "${local.bucket_names[count.index]}"
    Environment = "${local.environments[count.index]}"
    Terraform   = "true"
  }
}
