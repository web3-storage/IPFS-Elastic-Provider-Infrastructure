output "ipfs_peer_bitswap_config_bucket" {
  value = {
    bucket = aws_s3_bucket.ipfs_peer_bitswap_config.bucket
    id     = aws_s3_bucket.ipfs_peer_bitswap_config.id
    arn    = aws_s3_bucket.ipfs_peer_bitswap_config.arn
    region = aws_s3_bucket.ipfs_peer_bitswap_config.region
  }
}

output "sqs_multihashes_topic" {
  value = {
    url = aws_sqs_queue.multihashes_topic.url
    arn = aws_sqs_queue.multihashes_topic.arn
  }
}

output "dynamodb_blocks_policy" {
  value = {
    name = module.dynamodb.dynamodb_blocks_policy.name,
    arn  = module.dynamodb.dynamodb_blocks_policy.arn,
  }
}

output "dynamodb_car_policy" {
  value = {
    name = module.dynamodb.dynamodb_car_policy.name,
    arn  = module.dynamodb.dynamodb_car_policy.arn,
  }
}

output "s3_config_peer_bucket_policy_read" {
  value = {
    name = aws_iam_policy.s3_config_peer_bucket_policy_read.name,
    arn  = aws_iam_policy.s3_config_peer_bucket_policy_read.arn,
  }
}

output "sqs_multihashes_policy_send" {
  value = {
    name = aws_iam_policy.sqs_multihashes_policy_send.name,
    arn  = aws_iam_policy.sqs_multihashes_policy_send.arn,
  }
}

output "sqs_multihashes_policy_receive" {
  value = {
    name = aws_iam_policy.sqs_multihashes_policy_receive.name,
    arn  = aws_iam_policy.sqs_multihashes_policy_receive.arn,
  }
}


output "sqs_multihashes_policy_delete" {
  value = {
    name = aws_iam_policy.sqs_multihashes_policy_delete.name,
    arn  = aws_iam_policy.sqs_multihashes_policy_delete.arn,
  }
}