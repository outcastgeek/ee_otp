PROJECT = database_copy
PROJECT_DESCRIPTION = New project
PROJECT_VERSION = 0.0.1

BUILD_DEPS = lfe lfe.mk
dep_lfe.mk = git https://github.com/ninenines/lfe.mk master
DEP_PLUGINS = lfe.mk

DEPS = lfe cowboy jsx syslog_app goldrush p1_mysql epgsql
dep_lfe = hex 1.2.0
dep_cowboy_commit = master
dep_jsx = hex 2.8.0
dep_syslog_app = hex 3.0.0
dep_goldrush = hex 0.1.8
dep_p1_mysql = hex 1.0.1
dep_epgsql = hex 3.2.0

include erlang.mk

ROOT_DIR = $(shell pwd)
# SHELL_PATH = -pa ebin deps/*/ebin

proj-get-deps: deps

proj-build: app

proj-clean: distclean

run-app: all
	$(verbose) $(RELX_OUTPUT_DIR)/$(RELX_RELEASE)/bin/$(RELX_RELEASE) foreground

RELX_CONFIG = $(CURDIR)/relx-debug.config
run-debug: all
	$(verbose) $(RELX_OUTPUT_DIR)/$(RELX_RELEASE)/bin/$(RELX_RELEASE) console

