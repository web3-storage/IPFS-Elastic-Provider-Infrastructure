bitswap_load_balancer_dns         = "dualstack.ad634f66e6de04893ad9914ac2a7dbc9-1954649692.us-west-2.elb.amazonaws.com"
bitswap_load_balancer_hosted_zone = "Z1H1FL5HABSF5"
bitswap_peer_record = {
  name  = "elastic-<%= expansion(':ENV') %>"
  value = "dualstack.ad634f66e6de04893ad9914ac2a7dbc9-1954649692.us-west-2.elb.amazonaws.com"
}
