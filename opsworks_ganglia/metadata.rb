name        "opsworks_ganglia"
description "Installs Ganglia"
maintainer  "AWS OpsWorks"
license     "Apache 2.0"
version     "1.0.0"

depends "apache2"

recipe "opsworks_ganglia::server", "Ganglia server"
recipe "opsworks_ganglia::configure-server", "Reconfigure Ganglia server with correct clients"
recipe "opsworks_ganglia::client", "Ganglia client"
recipe "opsworks_ganglia::configure-client", "Reconfigure Ganglia client with correct server"
recipe "opsworks_ganglia::monitor-memcached", "Monitor Memcached"
recipe "opsworks_ganglia::monitor-mysql", "Monitor MySQL"
recipe "opsworks_ganglia::monitor-fd-and-sockets", "Monitor File Descriptors and Sockets"
recipe "opsworks_ganglia::monitor-disk", "Monitor Disk Stats"
recipe "opsworks_ganglia::monitor-apache", "Monitor Apache Stats"

depends 'apache2'
depends 'opsworks_commons'
depends 'opsworks_initial_setup'
