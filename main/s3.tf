resource "aws_s3_bucket" "discovery" {
  acl           = "private"
  bucket        = "${local.app_id}-discovery"
  force_destroy = true

  tags = merge({ Name = "${local.app_id}-S3" }, local.common_tags)
}
