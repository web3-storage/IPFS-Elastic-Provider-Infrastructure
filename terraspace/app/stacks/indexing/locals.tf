locals {
  environment_variables = {
    "CONCURRENCY"                 = var.concurrency
    "SKIP_PUBLISHING"             = "false"
    "NODE_ENV"                    = var.node_env
    "SQS_PUBLISHING_QUEUE_URL"    = var.shared_stack_sqs_multihashes_topic_url
    "SQS_NOTIFICATIONS_QUEUE_URL" = aws_sqs_queue.notifications_topic.url
    "DYNAMO_BLOCKS_TABLE"         = var.dynamodb_blocks_table
    "DYNAMO_CARS_TABLE"           = var.dynamodb_cars_table
    "S3_MAX_RETRIES"              = var.s3_max_retries
  }

  indexer_image_url = "${aws_ecr_repository.ecr_repo_indexer_lambda.repository_url}:${var.indexing_lambda_image_version}"
}
