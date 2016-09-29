PROJECT = lfe_cowboy
PROJECT_DESCRIPTION = A LFE / Cowboy Experiment with Prod Deployments (Heroku / Docker)
PROJECT_VERSION = 0.0.1

BUILD_DEPS = lfe lfe.mk
dep_lfe.mk = git https://github.com/ninenines/lfe.mk master
DEP_PLUGINS = lfe.mk

DEPS = cowboy
dep_cowboy = hex 1.0.4

include erlang.mk

run-app: all
	$(verbose) $(RELX_OUTPUT_DIR)/$(RELX_RELEASE)/bin/$(RELX_RELEASE) foreground
