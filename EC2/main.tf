resource "aws_instance" "test" {
  ami                         = var.ec2_ami
  instance_type               = var.ec2_instance_type
  cpu_core_count              = var.ec2_cpu_core_count
  cpu_threads_per_core        = var.ec2_cpu_threads_per_core
  hibernation                 = var.ec2_hibernation
  user_data                   = var.ec2_user_data
  user_data_base64            = var.ec2_user_data_base64
  #user_data_replace_on_change = var.ec2_user_data_replace_on_change
  availability_zone           = var.ec2_availability_zone
  subnet_id                   = var.ec2_subnet_id
  vpc_security_group_ids      = var.ec2_vpc_security_group_ids
  key_name                    = var.ec2_key_name
  monitoring                  = var.ec2_monitoring
  get_password_data           = var.ec2_get_password_data
  iam_instance_profile        = var.ec2_iam_instance_profile
  associate_public_ip_address = var.ec2_associate_public_ip_address
  private_ip                  = var.ec2_private_ip
  secondary_private_ips       = var.ec2_secondary_private_ips
  ipv6_address_count          = var.ec2_ipv6_address_count
  ipv6_addresses              = var.ec2_ipv6_addresses

  ebs_optimized = var.ec2_ebs_optimized

  dynamic "capacity_reservation_specification" {
    for_each = var.ec2_capacity_reservation_specification != null ? [var.ec2_capacity_reservation_specification] : []
    content {
      capacity_reservation_preference = lookup(capacity_reservation_specification.value, "capacity_reservation_preference", null)

      dynamic "capacity_reservation_target" {
        for_each = lookup(capacity_reservation_specification.value, "capacity_reservation_target", [])
        content {
          capacity_reservation_id = lookup(capacity_reservation_target.value, "capacity_reservation_id", null)
        }
      }
    }
  }

  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
      encrypted             = lookup(root_block_device.value, "encrypted", null)
      iops                  = lookup(root_block_device.value, "iops", null)
      kms_key_id            = lookup(root_block_device.value, "kms_key_id", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
      throughput            = lookup(root_block_device.value, "throughput", null)
      tags                  = lookup(root_block_device.value, "tags", null)
    }
  }

  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device
    content {
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
      device_name           = ebs_block_device.value.device_name
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      kms_key_id            = lookup(ebs_block_device.value, "kms_key_id", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
      throughput            = lookup(ebs_block_device.value, "throughput", null)
    }
  }

  dynamic "ephemeral_block_device" {
    for_each = var.ec2_ephemeral_block_device
    content {
      device_name  = ephemeral_block_device.value.device_name
      no_device    = lookup(ephemeral_block_device.value, "no_device", null)
      virtual_name = lookup(ephemeral_block_device.value, "virtual_name", null)
    }
  }

  dynamic "metadata_options" {
    for_each = var.ec2_metadata_options != null ? [var.ec2_metadata_options] : []
    content {
      http_endpoint               = lookup(metadata_options.value, "http_endpoint", "enabled")
      http_tokens                 = lookup(metadata_options.value, "http_tokens", "optional")
      http_put_response_hop_limit = lookup(metadata_options.value, "http_put_response_hop_limit", "1")
      instance_metadata_tags      = lookup(metadata_options.value, "instance_metadata_tags", null)
    }
  }

  dynamic "network_interface" {
    for_each = var.ec2_network_interface
    content {
      device_index          = network_interface.value.device_index
      network_interface_id  = lookup(network_interface.value, "network_interface_id", null)
      delete_on_termination = lookup(network_interface.value, "delete_on_termination", false)
    }
  }

  dynamic "launch_template" {
    for_each = var.ec2_launch_template != null ? [var.ec2_launch_template] : []
    content {
      id      = lookup(var.ec2_launch_template, "id", null)
      name    = lookup(var.ec2_launch_template, "name", null)
      version = lookup(var.ec2_launch_template, "version", null)
    }
  }

  enclave_options {
    enabled = var.ec2_enclave_options_enabled
  }

  source_dest_check                    = length(var.ec2_network_interface) > 0 ? null : var.ec2_source_dest_check
  disable_api_termination              = var.ec2_disable_api_termination
  instance_initiated_shutdown_behavior = var.ec2_instance_initiated_shutdown_behavior
  placement_group                      = var.ec2_placement_group
  tenancy                              = var.ec2_tenancy
  host_id                              = var.ec2_host_id

  credit_specification {
    cpu_credits = var.ec2_cpu_credits
  }
}
