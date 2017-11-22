# Default configuration for the AWS OpsWorks cookbook for Wordpress
#

# Enable the Wordpress W3 Total Cache plugin (http://wordpress.org/plugins/w3-total-cache/)?
default['wordpress']['wp_config']['enable_W3TC'] = false

# Force logins via https (http://codex.wordpress.org/Administration_Over_SSL#To_Force_SSL_Logins_and_SSL_Admin_Access)
default['wordpress']['wp_config']['force_secure_logins'] = false

# wordpress database connection variables
default['wordpress']['db']['password'] = ""
default['wordpress']['db']['host'] = "localhost"
default['wordpress']['db']['database'] = "wordpressdb"
default['wordpress']['db']['user'] = "root"

# wordpress installtion directory
default['wordpress']['dir'] = "/var/www/wordpress"
