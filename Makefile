

# .PHONY: help

.DEFAULT: help

help:
	@echo "chat-app"
	@echo "Daniel Vinciguerra (c) 2020\n"
	@echo "Usage: make [command] ARGS=[arguments]"
	@echo "\nCommands:"
	@grep -E '^[a-zA-Z_-]+:.*?##DESCRIBE: .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?##DESCRIBE: "}; {printf "  \033[36mmake %-10s\033[0m%s\n", $$1, $$2}'

backend_deps:
	cd backend && shards install && cd ..

frontend_deps:
	cd frontend && yarn install && cd ..

deps: backend_deps frontend_deps ##DESCRIBE install dependencies

start:  ##DESCRIBE: start application
	export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"
	foreman start

