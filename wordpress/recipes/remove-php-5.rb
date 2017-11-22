

execute 'a2dismod php5' do
  command 'a2dismod php5'
  user 'root'
end

apt_package "php5-common" do
  action :purge
  options '--allow-unauthenticated --assume-yes'
end

execute 'service apache2 restart' do
  command 'service apache2 restart'
end
