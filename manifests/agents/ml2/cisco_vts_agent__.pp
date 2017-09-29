# == Define: neutron::agents::ml2::cisco_vts_agent
#
# Install the Cisco VTS driver and generate the ML2 config file
# from parameters in the other classes.
#
# === Parameters
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
# [*vts_timeout*]
# (optional) Timeout for connection to vts host REST interface.
# Defaults to $::os_service_default
#
# [*vts_sync_timeout*]
# (optional) Timeout for synchronization to VTS.
# Defaults to $::os_service_default
#
# [*vts_retry_count*]
# (optional) Numer of retries for synchronization with VTS.
# Defaults to $::os_service_default
#
# [*vts_vmmid*]
# (optional) Virtual Machine Manager ID as assigned by VTS
# Defaults to $::os_service_default
#
#
class neutron::agents::ml2::cisco_vts_agent (
  $vts_username,
  $vts_password,
  $vts_url,
  $vts_timeout      = $::os_service_default,
  $vts_sync_timeout = $::os_service_default,
  $vts_retry_count  = $::os_service_default,
  $vts_vmmid,
) {

  include ::neutron::deps
  require neutron::agents::ml2::ovs

#  ensure_resource('package', 'python-cisco-controller',
#    {
#      ensure => $package_ensure,
#      tag    => 'openstack',
#    }
#  )

  neutron_agent_ovs {
    'ml2_ncs/username':     value => $vts_username;
    'ml2_ncs/password':     value => $vts_password, secret => true;
    'ml2_ncs/url':          value => $vts_url;
    'ml2_ncs/timeout':      value => $vts_timeout;
    'ml2_ncs/sync_timeout': value => $vts_sync_timeout;
    'ml2_ncs/retry_count':  value => $vts_retry_count;
    'ml2_ncs/vmm_id':        value => $vts_vmmid;
  }
}
