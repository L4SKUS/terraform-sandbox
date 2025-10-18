# module "s3_bucket" {
#   source                   = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket.git?ref=v5.0.0"
#   bucket                   = "test-sftp-bucket"
#   control_object_ownership = true
#   object_ownership         = "BucketOwnerEnforced"
#   block_public_acls        = true
#   block_public_policy      = true
#   ignore_public_acls       = true
#   restrict_public_buckets  = true

#   server_side_encryption_configuration = {
#     rule = {
#       apply_server_side_encryption_by_default = {
#         kms_master_key_id = aws_kms_key.transfer_family_key.arn
#         sse_algorithm     = "aws:kms"
#       }
#     }
#   }

#   versioning = {
#     enabled = false
#   }
# }

module "backend" {
  source                   = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket.git?ref=v5.8.1"
  bucket                   = "sandbox-backend-bucket-123456"
  control_object_ownership = true
  object_ownership         = "BucketOwnerEnforced"
  block_public_acls        = true
  block_public_policy      = true
  ignore_public_acls       = true
  restrict_public_buckets  = true
}
