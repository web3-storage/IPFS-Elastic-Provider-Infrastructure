lambda = {
  name        = "bucket-to-indexer"
  memory_size = 1024
  timeout     = 900
}

node_env              = "<%= expansion(':ENV') %>"
indexing_stack_region = "us-west-2"
