name "web_server"
description "Web server role."
run_list "recipe[apache2]","recipe[apache2::edit_virtualhost]"
