# 1. Create the S3 Bucket
resource "aws_s3_bucket" "weather_app" {
  bucket = var.bucket_name
}

# 2. Configure it as a Static Website
resource "aws_s3_bucket_website_configuration" "weather_app_website" {
  bucket = aws_s3_bucket.weather_app.id

  index_document {
    suffix = "index.html"
  }
}

# 3. Turn off the "Block Public Access" security feature
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.weather_app.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# 4. Attach a policy granting the world read access to the files
resource "aws_s3_bucket_policy" "allow_public_read" {
  bucket = aws_s3_bucket.weather_app.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.weather_app.arn}/*"
      },
    ]
  })

  # Ensure the security block is removed BEFORE applying the policy
  depends_on = [aws_s3_bucket_public_access_block.public_access]
}