template "#{node["apache"]["sites_available_dir"]}default" do
  source "site_available/a9b.local.erb"
  owner  "apache"
  group  "apache"
  mode   "0644"
  variables(
    :domain_name => node["apache"]["domain_name"],
    :doc_root    => node["apache"]["document_root"],
    :log_dir     => node["apache"]["log_dir"],
    :error_log   => node["apache"]["error_log"],
    :access_log  => node["apache"]["access_log"]
  )
end
