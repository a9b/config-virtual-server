# @editer seki 2014/04/03 12:56:04 
name "local"
description "for local development"

# yum::epelは、yum cookbookのepelレシピ
run_list(
  "recipe[yum::epel]",
  "recipe[yum::remi]",
  "recipe[php54]",
  "recipe[nginx]",
  "recipe[iptables]",
)
