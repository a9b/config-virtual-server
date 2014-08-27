default["apache"]["document_root"]       = "/var/www/html/"
default["apache"]["domain_name"]         = "a9b.local"
default["apache"]["sites_available_dir"] = "/etc/httpd/sites-available/"
default['apache']['listen_addresses']    = %w[192.168.0.200 a9b.local]
