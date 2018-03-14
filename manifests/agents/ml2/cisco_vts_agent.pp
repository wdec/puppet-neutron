#
# Copyright (C) 2017 Cisco Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
#
# == Class: neutron::agents::ml2::cisco_vts_agent
#
# Setups Cisco VTS OVS neutron agent when using ML2 plugin
#
# === Parameters
#
# VTS Specific
#
# [*vts_username*]
# (required) The VTS controller username
# Example: 'admin'
#
# [*vts_password*]
# (required) The VTS controller password
# Example: 'admin'
#
# [*vts_url*]
# (required) The VTS controller neutron URL
# Example: 'http://127.0.0.1:8888/api/running/openstack'
#
# [*vts_agent_retries*]
# (optional) Retries for connection to VTS host REST interface.
# Defaults to $::os_service_default
#
# [*vts_agent_polling_interval*]
# (optional) VTS Polling interval.
# Defaults to $::os_service_default
#
# [*vts_phys_net*]
# (optional) Name of physical network connected to VTS.
# Defaults to $::os_service_default
#
# [*vts_vmmid*]
# (optional) Virtual Machine Manager ID as assigned by VTS
# Defaults to $::os_service_default
#
# Default OVS parameters
#
# [*package_ensure*]
#   (optional) The state of the package
#   Defaults to 'present'
#
# [*enabled*]
#   (required) Whether or not to enable the OVS Agent
#   Defaults to true
#
# [*manage_service*]
#   (optional) Whether to start/stop the service
#   Defaults to true
#
# [*bridge_uplinks*]
#   (optional) List of interfaces to connect to the bridge when doing
#   bridge mapping.
#   Defaults to empty list
#
# [*bridge_mappings*]
#   (optional) List of <physical_network>:<bridge>
#   Defaults to empty list
#
# [*integration_bridge*]
#   (optional) Integration bridge in OVS
#   Defaults to 'br-int'
#
# [*tunnel_types*]
#   (optional) List of types of tunnels to use when utilizing tunnels,
#   either 'gre' or 'vxlan'.
#   Defaults to empty list
#
# [*local_ip*]
#   (optional) Local IP address of GRE tunnel endpoints.
#   Required when enabling tunneling
#   Defaults to false
#
# [*tunnel_bridge*]
#   (optional) Bridge used to transport tunnels
#   Defaults to 'br-tun'
#
# [*vxlan_udp_port*]
#   (optional) The UDP port to use for VXLAN tunnels.
#   Defaults to '4789'
#
# [*polling_interval*]
#   (optional) The number of seconds the agent will wait between
#   polling for local device changes.
#   Defaults to $::os_service_default
#
# [*l2_population*]
#   (optional) Extension to use alongside ml2 plugin's l2population
#   mechanism driver.
#   Defaults to $::os_service_default
#
# [*arp_responder*]
#   (optional) Enable or not the ARP responder.
#   Recommanded when using l2 population mechanism driver.
#   Defaults to $::os_service_default
#
# [*firewall_driver*]
#   (optional) Firewall driver for realizing neutron security group function.
#   Defaults to 'neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver'.
#
# [*enable_distributed_routing*]
#   (optional) Set to True on L2 agents to enable support
#   for distributed virtual routing.
#   Defaults to $::os_service_default
#
# [*drop_flows_on_start*]
#   (optional) Set to True to drop all flows during agent start for a clean
#   flow tables resetting
#   Defaults to false
#
# [*manage_vswitch*]
#   (optional) This boolean is used to indicate if this class should manage the
#   vswitch software installation and the ovs bridges/ports from the
#   $bridge_mappings parameter. If manage_vswitch is set to true, then we will
#   require the vswitch::ovs and configure the ovs bridges/ports using the
#   mappings provided as part of the $bridge_mappings parameters.
#   Defaults to true
#
# [*extensions*]
#   (optional) Extensions list to use
#   Defaults to $::os_service_default
#
# [*int_peer_patch_port*]
#   (optional) Peer patch port in integration bridge for tunnel bridge
#   Defaults to $::os_service_default
#
# [*tun_peer_patch_port*]
#   (optional) Peer patch port in tunnel bridge for integration bridge
#   Defaults to $::os_service_default
#
# [*datapath_type*]
#   (optional) Datapath type for ovs bridges
#   Defaults to $::os_service_default
#
# [*vhostuser_socket_dir*]
#   (optional) The vhost-user socket directory for OVS
#   Defaults to $::os_service_default
#
# [*of_interface*]
#   (optional) OpenFlow interface to use
#   Allowed values: ovs-ofctl, native
#   Defaults to $::os_service_default
#
# [*ovsdb_interface*]
#   (optional) The interface for interacting with the OVSDB
#   Allowed values: vsctl, native
#   Defaults to $::os_service_default
#
# [*purge_config*]
#   (optional) Whether to set only the specified config options
#   in the ovs config.
#   Defaults to false.
#
# [*enable_dpdk*]
#   (optional) Enable or not DPDK with OVS
#   Defaults to false.
#
# [*minimize_polling*]
#  (optional) Minimize polling by monitoring ovsdb for interface
#  changes. (boolean value)
#  Defaults to $::os_service_default
#
# === Deprecated Parameters
#
# [*enable_tunneling*]
#   (optional) Enable or not tunneling
#   Defaults to false
#
class neutron::agents::ml2::cisco_vts_agent (
  # Cisco VTS parameters
  $vts_url                    = $::os_service_default,
  $vts_username               = hiera('neutron::plugins::ml2::cisco_vts_agent::vts_username'),
  $vts_password               = hiera('neutron::plugins::ml2::cisco_vts_agent::vts_password'),
  $vts_timeout                = hiera('neutron::plugins::ml2::cisco_vts_agent::vts_timeout'),
  $vts_agent_retries          = $::os_service_default,
  $vts_agent_polling_interval = $::os_service_default,
  $vts_vmmid                  = hiera('neutron::plugins::ml2::cisco::vts::vts_vmmid'),
  $vts_phys_net               = $::os_service_default,
  $package_ensure             = 'present',
  $enabled                    = true,
  $manage_service             = true,
  $extensions                 = $::os_service_default,
  $bridge_uplinks             = [],
  $bridge_mappings            = [],
  $integration_bridge         = 'br-int',
  $tunnel_types               = [],
  $local_ip                   = false,
  $tunnel_bridge              = 'br-tun',
  $vxlan_udp_port             = 4789,
  $polling_interval           = $::os_service_default,
  $l2_population              = $::os_service_default,
  $arp_responder              = $::os_service_default,
  $firewall_driver            = 'neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver',
  $enable_distributed_routing = $::os_service_default,
  $drop_flows_on_start        = false,
  $manage_vswitch             = true,
  $int_peer_patch_port        = $::os_service_default,
  $tun_peer_patch_port        = $::os_service_default,
  $datapath_type              = $::os_service_default,
  $vhostuser_socket_dir       = $::os_service_default,
  $of_interface               = $::os_service_default,
  $ovsdb_interface            = $::os_service_default,
  $purge_config               = false,
  $enable_dpdk                = false,
  $minimize_polling           = $::os_service_default,
  # DEPRECATED PARAMETERS
  $prevent_arp_spoofing       = $::os_service_default,
) {

  include ::neutron::deps
  include ::neutron::params

  if $enable_dpdk and ! $manage_vswitch {
    fail('Enabling DPDK without manage vswitch does not have any effect')
  }

  if $enable_dpdk and is_service_default($datapath_type) {
    fail('Datapath type for ovs agent must be set when DPDK is enabled')
  }

  if $enable_dpdk and is_service_default($vhostuser_socket_dir) {
    fail('vhost user socket directory for ovs agent must be set when DPDK is enabled')
  }

  if $manage_vswitch {
    if $enable_dpdk {
      require ::vswitch::dpdk
    } else {
      require ::vswitch::ovs
    }
  }

  if $enable_tunneling {
    warning('The enable_tunneling parameter is deprecated.  Please set tunnel_types with the desired type to enable tunneling.')
  }

  validate_array($tunnel_types)
  if $enable_tunneling or (size($tunnel_types) > 0) {
    $enable_tunneling_real = true
  } else {
    $enable_tunneling_real = false
  }

  if $enable_tunneling_real and ! $local_ip {
    fail('Local ip for ovs agent must be set when tunneling is enabled')
  }

  if ($enable_tunneling_real) and (!is_service_default($enable_distributed_routing)) and (!is_service_default($l2_population)) {
    if $enable_distributed_routing and ! $l2_population {
      fail('L2 population must be enabled when DVR and tunneling are enabled')
    }
  }

  if ! (is_service_default($of_interface)) and ! ($of_interface =~ /^(ovs-ofctl|native)$/) {
    fail('A value of $of_interface is incorrect. The allowed values are ovs-ofctl and native')
  }

  if ! (is_service_default($ovsdb_interface)) and ! ($ovsdb_interface =~ /^(vsctl|native)$/) {
    fail('A value of $ovsdb_interface is incorrect. The allowed values are vsctl and native')
  }

  resources { 'neutron_cisco_vts_agent':
    purge => $purge_config,
  }

  if ($bridge_mappings != []) {
    # bridge_mappings are used to describe external networks that are
    # *directly* attached to this machine.
    # (This has nothing to do with VM-VM comms over neutron virtual networks.)
    # Typically, the network node - running L3 agent - will want one external
    # network (often this is on the control node) and the other nodes (all the
    # compute nodes) will want none at all.  The only other reason you will
    # want to add networks here is if you're using provider networks, in which
    # case you will name the network with bridge_mappings and add the server's
    # interfaces that are attached to that network with bridge_uplinks.
    # (The bridge names can be nearly anything, they just have to match between
    # mappings and uplinks; they're what the OVS switches will get named.)

    # Set config for bridges that we're going to create
    # The OVS neutron plugin will talk in terms of the networks in the bridge_mappings
    $br_map_str = join($bridge_mappings, ',')
    neutron_cisco_vts_agent {
      'ovs/bridge_mappings': value => $br_map_str;
    }
    if ($manage_vswitch) {
      neutron::plugins::ovs::bridge{ $bridge_mappings:
        before => Service['neutron-vts-agent'],
      }
      neutron::plugins::ovs::port{ $bridge_uplinks:
        before => Service['neutron-vts-agent'],
      }
    }
  }

  neutron_cisco_vts_agent {
    'agent/polling_interval':           value => $polling_interval;
    'agent/l2_population':              value => $l2_population;
    'agent/arp_responder':              value => $arp_responder;
    'agent/enable_distributed_routing': value => $enable_distributed_routing;
    'agent/drop_flows_on_start':        value => $drop_flows_on_start;
    'agent/extensions':                 value => join(any2array($extensions), ',');
    'agent/minimize_polling':           value => $minimize_polling;
    'ovs/integration_bridge':           value => $integration_bridge;
    'ovs/datapath_type':                value => $datapath_type;
    'ovs/vhostuser_socket_dir':         value => $vhostuser_socket_dir;
    'ovs/ovsdb_interface':              value => $ovsdb_interface;
    'ovs/of_interface':                 value => $of_interface;

    'ml2_ncs/username':                 value => $vts_username;
    'ml2_ncs/password':                 value => $vts_password;
    'ml2_ncs/url':                      value => $vts_url;
    'ml2_ncs/timeout':                  value => $vts_timeout;
    'ml2_ncs/polling_interval':         value => $vts_agent_polling_interval;
    'ml2_ncs/max_ncs_retries':          value => $vts_agent_retries;
    'ml2_ncs/vmm_id':                   value => $vts_vmmid;
    'ml2_ncs/physnet_name':             value => $vts_phys_net;
  }

  if $firewall_driver {
    neutron_cisco_vts_agent { 'securitygroup/firewall_driver': value => $firewall_driver }
  } else {
    neutron_cisco_vts_agent { 'securitygroup/firewall_driver': ensure => absent }
  }

  if $enable_tunneling_real {
    neutron_cisco_vts_agent {
      'ovs/tunnel_bridge':         value => $tunnel_bridge;
      'ovs/local_ip':              value => $local_ip;
      'ovs/int_peer_patch_port':   value => $int_peer_patch_port;
      'ovs/tun_peer_patch_port':   value => $tun_peer_patch_port;
      'agent/tunnel_types':        value => join($tunnel_types, ',');
    }

    if 'vxlan' in $tunnel_types {
      validate_vxlan_udp_port($vxlan_udp_port)
      neutron_cisco_vts_agent {
        'agent/vxlan_udp_port': value => $vxlan_udp_port;
      }
    }
  } else {
    neutron_cisco_vts_agent {
      'ovs/tunnel_bridge':         ensure => absent;
      'ovs/local_ip':              ensure => absent;
      'ovs/int_peer_patch_port':   ensure => absent;
      'ovs/tun_peer_patch_port':   ensure => absent;
    }
  }


#  if $::neutron::params::ovs_agent_package {
#    package { 'neutron-ovs-agent':
#      ensure => $package_ensure,
#      name   => $::neutron::params::ovs_agent_package,
#      tag    => ['openstack', 'neutron-package'],
#    }
#  } else {
#    # Some platforms (RedHat) do not provide a separate
#    # neutron plugin ovs agent package. The configuration file for
#    # the ovs agent is provided by the neutron ovs plugin package.
#    if ! defined(Package['neutron-ovs-agent']) {
#      package { 'neutron-ovs-agent':
#        ensure => $package_ensure,
#        name   => $::neutron::params::ovs_server_package,
#        tag    => ['openstack', 'neutron-package'],
#      }
#    }
#  }

  package { 'cisco-vts-agent':
    ensure => $package_ensure,
    name   => 'cisco-vts-agent',
    tag    => ['openstack', 'neutron-package'],
  }

  if $manage_service {
    if $enabled {
      $service_ensure = 'running'
    } else {
      $service_ensure = 'stopped'
    }
  }

  service { 'neutron-vts-agent':
    ensure => $service_ensure,
    name   => 'neutron-vts-agent',
    enable => $enabled,
    tag    => ['neutron-service', 'neutron-db-sync-service'],
  }

  if ($::osfamily == 'Redhat') {
    service { 'neutron-destroy-patch-ports-service':
      ensure => $service_ensure,
      name   => $::neutron::params::destroy_patch_ports_service,
      enable => $enabled,
      tag    => ['neutron-service'],
    }
  }

  if $::neutron::params::ovs_cleanup_service {
    service { 'ovs-cleanup-service':
      name    => $::neutron::params::ovs_cleanup_service,
      enable  => $enabled,
      # TODO: Remove this require once ovs-cleanup service
      # script is packaged in neutron-openvswitch package
      require => Anchor['neutron::install::end'],
    }
  }
}
