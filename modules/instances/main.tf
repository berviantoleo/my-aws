resource "aws_instance" "default_0" {
  provider                             = aws.ap-southeast-3
  ami                                  = "ami-0722d2ef628f40e11"
  availability_zone                    = "ap-southeast-3c"
  disable_api_stop                     = false
  disable_api_termination              = false
  ebs_optimized                        = true
  force_destroy                        = null
  get_password_data                    = false
  hibernation                          = false
  iam_instance_profile                 = "SSMInstanceProfile"
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "c6g.medium"
  key_name                             = "fedora-berv"
  monitoring                           = false
  placement_partition_number           = 0
  region                               = "ap-southeast-3"
  tags = {
    Name = "kube-k3s-arm"
  }
  tags_all = {
    Name = "kube-k3s-arm"
  }
  tenancy                     = "default"
  user_data                   = null
  user_data_replace_on_change = null
  volume_tags                 = null
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  cpu_options {
    core_count       = 1
    threads_per_core = 1
  }
  enclave_options {
    enabled = false
  }
  maintenance_options {
    auto_recovery = "default"
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
    instance_metadata_tags      = "disabled"
  }
  primary_network_interface {
    network_interface_id = "eni-0ff8f03018eea8c73"
  }
  private_dns_name_options {
    enable_resource_name_dns_a_record    = true
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    iops                  = 3000
    tags                  = {}
    tags_all              = {}
    throughput            = 125
    volume_size           = 15
    volume_type           = "gp3"
  }
  timeouts {
    create = null
    delete = null
    read   = null
    update = null
  }
}

resource "aws_instance" "default_1" {
  provider                             = aws.ap-southeast-3
  ami                                  = "ami-093bbf368c0fe38fe"
  availability_zone                    = "ap-southeast-3b"
  disable_api_stop                     = false
  disable_api_termination              = false
  ebs_optimized                        = true
  force_destroy                        = null
  get_password_data                    = false
  hibernation                          = false
  iam_instance_profile                 = "SSMInstanceProfile"
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t3.small"
  key_name                             = "fedora-berv"
  monitoring                           = false
  placement_partition_number           = 0
  region                               = "ap-southeast-3"
  tags = {
    Name = "submission-vm-docker-compose"
  }
  tags_all = {
    Name = "submission-vm-docker-compose"
  }
  tenancy                     = "default"
  user_data                   = null
  user_data_replace_on_change = null
  volume_tags                 = null
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  cpu_options {
    core_count       = 1
    threads_per_core = 2
  }
  credit_specification {
    cpu_credits = "unlimited"
  }
  enclave_options {
    enabled = false
  }
  maintenance_options {
    auto_recovery = "default"
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "disabled"
  }
  primary_network_interface {
    network_interface_id = "eni-0a0ddf1b9f5a731d9"
  }
  private_dns_name_options {
    enable_resource_name_dns_a_record    = true
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    iops                  = 3000
    tags                  = {}
    tags_all              = {}
    throughput            = 125
    volume_size           = 10
    volume_type           = "gp3"
  }
  timeouts {
    create = null
    delete = null
    read   = null
    update = null
  }
}

resource "aws_instance" "default_2" {
  provider                             = aws.ap-southeast-3
  ami                                  = "ami-05f7d94ba61b4956f"
  availability_zone                    = "ap-southeast-3b"
  disable_api_stop                     = false
  disable_api_termination              = false
  ebs_optimized                        = true
  force_destroy                        = null
  get_password_data                    = false
  hibernation                          = false
  iam_instance_profile                 = "SSMInstanceProfile"
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t3.large"
  key_name                             = "mylinux"
  monitoring                           = false
  placement_partition_number           = 0
  region                               = "ap-southeast-3"
  tags = {
    Name = "mc-server"
  }
  tags_all = {
    Name = "mc-server"
  }
  tenancy                     = "default"
  user_data                   = null
  user_data_replace_on_change = null
  volume_tags                 = null
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  cpu_options {
    core_count       = 1
    threads_per_core = 2
  }
  credit_specification {
    cpu_credits = "unlimited"
  }
  enclave_options {
    enabled = false
  }
  maintenance_options {
    auto_recovery = "default"
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
    instance_metadata_tags      = "disabled"
  }
  primary_network_interface {
    network_interface_id = "eni-0c89d26ba6aee1bac"
  }
  private_dns_name_options {
    enable_resource_name_dns_a_record    = true
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    iops                  = 3000
    tags                  = {}
    tags_all              = {}
    throughput            = 125
    volume_size           = 25
    volume_type           = "gp3"
  }
  timeouts {
    create = null
    delete = null
    read   = null
    update = null
  }
}