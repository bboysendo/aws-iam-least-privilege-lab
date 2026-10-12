output "bucket_name" {
  description = "Name of the S3 bucket the lab is scoped around."
  value       = aws_s3_bucket.app_assets.id
}

output "ec2_role_arn" {
  description = "ARN of the IAM role the EC2 instance assumes — use this with the IAM Policy Simulator."
  value       = aws_iam_role.ec2_s3_readonly.arn
}

output "developers_group_name" {
  description = "Name of the IAM group holding the scoped developer policy."
  value       = aws_iam_group.developers.name
}

output "instance_id" {
  description = "ID of the demo EC2 instance — use with 'aws ssm start-session --target <id>'."
  value       = aws_instance.app.id
}

output "account_id" {
  description = "AWS account ID this lab was applied into (sanity check)."
  value       = data.aws_caller_identity.current.account_id
}
