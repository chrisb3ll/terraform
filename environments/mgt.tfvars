# management

availability_zones = "eu-west-1a,eu-west-1b"
cidr_block         = "10.0.0.0/22"
public_subnets     = "10.0.0.0/26,10.0.0.64/26"
private_subnets    = "10.0.1.0/26,10.0.1.64/26"

# VPN: configure the following for your environment
bgp_asn                = "00000"
aws_customer_gateways  = "0.0.0.0"
destination_cidr_block = "10.0.0.0/8"
