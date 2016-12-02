PROJECT = emq-relx
PROJECT_DESCRIPTION = Release project for the EMQ Broker
PROJECT_VERSION = 3.0

DEPS = emqttd emq_dashboard emq_recon emq_reloader emq_stomp emq_plugin_template \
	   emq_mod_rewrite emq_mod_presence emq_mod_retainer emq_mod_subscription \
	   emq_auth_clientid emq_auth_username emq_auth_ldap emq_auth_http \
	   emq_auth_mysql emq_auth_pgsql emq_auth_redis emq_auth_mongo \
	   emq_sn emq_coap

# emq deps
dep_emqttd        = git https://github.com/emqtt/emqttd emq30
dep_emq_dashboard = git https://github.com/emqtt/emq-dashboard emq30
dep_emq_recon     = git https://github.com/emqtt/emq-recon emq30
dep_emq_reloader  = git https://github.com/emqtt/emq-reloader emq30
dep_emq_stomp     = git https://github.com/emqtt/emq-stomp emq30

# emq modules
dep_emq_mod_presence     = git https://github.com/emqtt/emq-mod-presence emq30
dep_emq_mod_retainer     = git https://github.com/emqtt/emq-mod-retainer emq30
dep_emq_mod_rewrite      = git https://github.com/emqtt/emq-mod-rewrite emq30
dep_emq_mod_subscription = git https://github.com/emqtt/emq-mod-subscription emq30

# emq auth/acl plugins
dep_emq_auth_clientid   = git https://github.com/emqtt/emq-auth-clientid emq30
dep_emq_auth_username   = git https://github.com/emqtt/emq-auth-username emq30
dep_emq_auth_ldap       = git https://github.com/emqtt/emq-auth-ldap emq30
dep_emq_auth_http       = git https://github.com/emqtt/emq-auth-http emq30
dep_emq_auth_mysql      = git https://github.com/emqtt/emq-auth-mysql emq30
dep_emq_auth_pgsql      = git https://github.com/emqtt/emq-auth-pgsql emq30
dep_emq_auth_redis      = git https://github.com/emqtt/emq-auth-redis emq30
dep_emq_auth_mongo      = git https://github.com/emqtt/emq-auth-mongo emq30
dep_emq_plugin_template = git https://github.com/emqtt/emq-plugin-template emq30

# mqtt-sn and coap
dep_emq_sn 	= git https://github.com/emqtt/emq-sn emq30
dep_emq_coap = git https://github.com/emqtt/emq-coap emq30

# COVER = true

include erlang.mk

plugins:
	@rm -rf rel
	@mkdir -p rel/conf/plugins/ rel/schema/
	@for conf in $(DEPS_DIR)/*/etc/*.conf* ; do \
		if [ "emq.conf" = "$${conf##*/}" ] ; then \
			cp $${conf} rel/conf/ ; \
		elif [ "acl.conf" = "$${conf##*/}" ] ; then \
			cp $${conf} rel/conf/ ; \
		else \
			cp $${conf} rel/conf/plugins ; \
		fi ; \
	done
	@for schema in $(DEPS_DIR)/*/priv/*.schema ; do \
		cp $${schema} rel/schema/ ; \
	done

app:: plugins

