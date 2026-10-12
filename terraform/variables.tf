variable "aws_region" {
  description = "AWS region to deploy into."
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Globally-unique S3 bucket name for the application assets bucket."
  type        = string
}

variable "project_name" {
  description = "Short name used as a prefix/tag for all resources in this lab."
  type        = string
  default     = "iam-lab"
}

variable "create_demo_iam_user" {
  description = "Whether to create the optional demo IAM user (no console password, no access key by default). Off by default so applying this lab doesn't leave an extra IAM identity in your account unless you opt in."
  type        = bool
  default     = false
}

variable "instance_type" {
  description = "EC2 instance type for the demo application host. t3.micro is Free-Tier eligible on new accounts."
  type        = string
  default     = "t3.micro"
}
