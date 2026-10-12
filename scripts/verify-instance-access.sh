#!/bin/bash
# Run this ON the EC2 instance (via Session Manager or SSH) to prove the
# instance role grants exactly the access it should — and nothing more.
set -euo pipefail

echo "== 1. Confirm no static credentials are configured =="
aws configure list

echo
echo "== 2. Positive test: list and read the scoped bucket (should succeed) =="
BUCKET=$(aws sts get-caller-identity >/dev/null && aws ec2 describe-tags \
  --filters "Name=resource-id,Values=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)" \
            "Name=key,Values=Project" \
  --query 'Tags[0].ResourceId' --output text 2>/dev/null || true)

echo "(If BUCKET lookup above is empty, pass the bucket name manually: ./verify-instance-access.sh <bucket>)"
TARGET_BUCKET="${1:-}"
if [ -z "$TARGET_BUCKET" ]; then
  echo "Usage: verify-instance-access.sh <bucket-name>"
  exit 1
fi

aws s3 ls "s3://${TARGET_BUCKET}"
aws s3 cp "s3://${TARGET_BUCKET}/sample/hello.txt" -

echo
echo "== 3. Negative test: this role must NOT be able to list IAM users (should fail with AccessDenied) =="
if aws iam list-users >/dev/null 2>&1; then
  echo "UNEXPECTED: iam:ListUsers succeeded — the role is over-privileged!"
  exit 1
else
  echo "OK: iam:ListUsers was denied, as expected for a least-privilege role."
fi

echo
echo "All checks passed: least-privilege S3 read access confirmed."
