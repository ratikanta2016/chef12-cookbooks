name        "deploy"
description "Deploy applications"
maintainer  "AWS OpsWorks"
license     "Apache 2.0"
version     "1.0.0"

depends "scm_helper"
depends "mod_php5_apache2"


recipe "deploy::php", "Deploy a PHP application"
