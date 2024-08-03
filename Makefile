SHELL := /bin/bash
DEFAULT_GOAL := help
THIS_FILE := $(lastword $(MAKEFILE_LIST))

help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-27s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: start
start: ## Start application
	@echo -e "\033[33mstart\033[0m"

	@docker network create \
	  				--driver=bridge \
	  				--attachable \
					--internal=false \
	  				bpi-traefik \
	  				|| true

	@USERID=$$(id -u) GROUPID=$$(id -g) docker compose --file docker-compose.yml up
