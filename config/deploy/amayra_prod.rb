set :deploy_to, '/deploy/TACRM_AMAYRA'
server 'bman917.com', user: 'jchan', roles: %w{web app db}, :MYSQL_PASSWORD => fetch(:MYSQL_PASSWORD)