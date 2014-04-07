template "#{node["apache"]["sites_available_dir"]}default" do
  source "site_available/hogehoge.com.erb"
  owner  "apache"
  group  "apache"
  mode   "0644"
  variables(
    :domain_name => node["apache"]["domain_name"],
    :doc_root    => node["apache"]["document_root"]
  )
end
