# A sample Gemfile
# mixlib-shelloutだけ入らないでLoadErrorがありうる
source "https://rubygems.org"
 
# gem "rails"
#ruby '2.0.0'
ruby '1.9.3'
 
# ruby-wmiはohaiで必要
platforms :mswin, :mingw do
  gem "win32-process"
  gem "windows-pr"
  gem "ruby-wmi"
end
 
gem "yajl-ruby", :git => 'git://github.com/brianmario/yajl-ruby.git'
gem "chef-zero"
gem "berkshelf"
gem "knife-solo"
gem "chef"
