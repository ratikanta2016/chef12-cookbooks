# AWS OpsWorks Recipe for Wordpress to be executed during the Configure lifecycle phase
# - Creates the config file wp-config.php with MySQL data.
# - Creates a Cronjob.
# - Imports a database backup if it exists.

require 'uri'
require 'net/http'
require 'net/https'

uri = URI.parse("https://api.wordpress.org/secret-key/1.1/salt/")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
request = Net::HTTP::Get.new(uri.request_uri)
response = http.request(request)
keys = response.body


# Create the Wordpress config file wp-config.php with corresponding values
node[:deploy].each do |app_name, deploy|

    template "#{deploy[:deploy_to]}/current/wp-config.php" do
        source "wp-config-nh.php.erb"
        mode 0660
        group deploy[:group]

        if platform?("ubuntu")
          owner "www-data"
        elsif platform?("amazon")
          owner "apache"
        end

        variables(
            :database   => (node['wordpress']['db']['database'] rescue nil),
            :user       => (node['wordpress']['db']['user'] rescue nil),
            :password   => (node['wordpress']['db']['password'] rescue nil),
            :host       => (node['wordpress']['db']['host'] rescue nil),
            :aws_access_key => (node['wordpress']['aws']['access_key_id'] rescue nil),
            :aws_secret_access_key => (node['wordpress']['aws']['access_key'] rescue nil),
            :keys       => (keys rescue nil)
        )
    end

    # Following code snippet creates .htaccess file with multisite config
    template "#{deploy[:deploy_to]}/current/.htaccess" do
        source "htaccess.htaccess.erb"
        mode 0664
        group deploy[:group]
    end


	# Import Wordpress database backup from file if it exists

#mysql_command = "/usr/bin/mysql -h #{deploy[:database][:host]} -u #{deploy[:database][:username]} #{node[:mysql][:server_root_password].blank? ? '' : "-p#{node[:mysql][:server_root_password]}"} #{deploy[:database][:database]}"

#	Chef::Log.debug("Importing Wordpress database backup...")
#	script "memory_swap" do
#		interpreter "bash"
#		user "root"
#		cwd "#{deploy[:deploy_to]}/current/"
#		code <<-EOH
#			if ls #{deploy[:deploy_to]}/current/*.sql &> /dev/null; then
#				#{mysql_command} < #{deploy[:deploy_to]}/current/*.sql;
#				rm #{deploy[:deploy_to]}/current/*.sql;
#			fi;
#		EOH
#	end


end

# Create a Cronjob for Wordpress
# cron "wordpress" do
#   hour "*"
#   minute "*/15"
#   weekday "*"
#   command "wget -q -O - http://localhost/wp-cron.php?doing_wp_cron >/dev/null 2>&1"
# end
