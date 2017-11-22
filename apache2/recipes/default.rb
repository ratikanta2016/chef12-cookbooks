# AWS OpsWorks Recipe for Wordpress to be executed in setup time
# - install apache2
execute 'apt-get update' do
  command 'apt-get update'
  user 'root'
end

apt_package "apache2" do
  action :install
  options '--allow-unauthenticated --assume-yes'
end
