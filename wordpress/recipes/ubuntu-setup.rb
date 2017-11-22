# AWS OpsWorks Recipe for Wordpress to be executed in setup time
# - Disable mod php5
# - Remove PHP 5.*
# - Add new PHP 7 repo to server
# - Update package manager
# - Install PHP 7.0 https://www.tecmint.com/install-different-php-versions-in-ubuntu/
# - Install MySql
# - Install needed libraries
# - Install send mail package
# - Enable rewrite mod

#execute 'a2dismod php5' do
#  command 'a2dismod php5'
#  user 'root'
#end

#execute 'apt-get purge php5-common' do
#  command 'apt-get purge php5-common'
#end

# execute 'add-apt-repository ppa:ondrej/php' do
#   command 'add-apt-repository ppa:ondrej/php'
#   user 'root'
# end
#
# execute 'apt-get update' do
#   command 'apt-get update'
#   user 'root'
# end

#execute 'apt-get -y --force-yes install php7.0' do
#  command 'apt-get -y --force-yes install php7.0'
#  user 'root'
#end

 apt_package "php7.0" do
   action :install
   options '--allow-unauthenticated --assume-yes'
 end

#execute 'apt-get -y  --force-yes install php7.0-cli php7.0-xml php7.0-mysql libapache2-mod-php7.0 php7.0-mcrypt' do
# command 'apt-get -y  --force-yes install php7.0-cli php7.0-xml php7.0-mysql libapache2-mod-php7.0 php7.0-mcrypt'
# user 'root'
#end

 %w{php7.0-cli php7.0-xml php7.0-mysql libapache2-mod-php7.0 php7.0-mcrypt php7.0-curl}.each do |pkg|
    apt_package pkg do
       action :install
       options '--allow-unauthenticated --assume-yes'
    end
 end

execute 'update-alternatives --set php /usr/bin/php7.0' do
  command 'update-alternatives --set php /usr/bin/php7.0'
  user 'root'
end

execute 'a2enmod php7.0' do
  command 'a2enmod php7.0'
  user 'root'
end

# apt_package "php7.0-curl" do
#       action :install
#       options '--allow-unauthenticated --assume-yes'
# end

 apt_package "sendmail" do
   action :install
   options '--allow-unauthenticated --assume-yes'
 end

#execute 'apt-get -y  --force-yes install sendmail' do
# command 'apt-get -y  --force-yes install sendmail'
#end

execute 'a2enmod rewrite' do
  command 'a2enmod rewrite'
end

execute 'service apache2 restart' do
  command 'service apache2 restart'
end
