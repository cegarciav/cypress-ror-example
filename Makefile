.PHONY: start build db-restart up down rails-console rails-install help

STAGE := test
TEST_SCOPE := .
COMPOSE_FILE := ./docker-compose.yml

ifeq ($(STAGE), dev)
	ENV_FILE = .env.dev
else
	ifeq ($(STAGE), prod)
		ENV_FILE = .env
	else
		ENV_FILE = .env.test
	endif
endif

COMPOSE_SETUP := $(shell command -v docker-compose || echo 'docker compose')

start:
	$(info Make: start RoR app in detached mode)
	$(COMPOSE_SETUP) -f $(COMPOSE_FILE) --env-file ${ENV_FILE} up -d;


build:
	$(info Make: build RoR app image)
	$(COMPOSE_SETUP) -f $(COMPOSE_FILE) --env-file ${ENV_FILE} build;


db-restart:
	$(info Make: clear and seed the db)
	@if [ $(STAGE) = test ]; then \
		$(COMPOSE_SETUP) -f $(COMPOSE_FILE) --env-file ${ENV_FILE} run --rm web bin/rails db:seed; \
	else \
		echo Command not available in $(STAGE) stage; \
	fi


up:
	$(info Make: start RoR app)
	$(COMPOSE_SETUP) -f $(COMPOSE_FILE) --env-file ${ENV_FILE} up;


down:
	$(info Make: remove RoR app and its dependencies)
	$(COMPOSE_SETUP) -f $(COMPOSE_FILE) --env-file ${ENV_FILE} down --remove-orphans;


rails-console:
	$(info Make: enter RoR app's console)
	$(COMPOSE_SETUP) -f $(COMPOSE_FILE) --env-file ${ENV_FILE} run --rm web bin/rails console;


rails-install:
	$(info Make: enter RoR app's console)
	$(COMPOSE_SETUP) -f $(COMPOSE_FILE) --env-file ${ENV_FILE} run --rm web bin/bundle install;


rails-dbcreate:
	$(info Make: create RoR app's db)
	$(COMPOSE_SETUP) -f $(COMPOSE_FILE) --env-file ${ENV_FILE} run --rm web bin/rails db:create;


help:
	@echo ''
	@echo 'Usage: make [TARGET] [EXTRA_ARGUMENTS]'
	@echo 'Targets:'
	@echo '  start                 starts service in background. Default make command.'
	@echo '  build                 builds service in background.'
	@echo '  db-restart            clears and seed the database. Only available in test stage'
	@echo '  up                    starts services in foreground.'
	@echo '  down                  downstreams the service and removes orphans.'
	@echo '  rails-console         opens rails console.'
	@echo '  rails-install         install gems based on Gemfile.'
	@echo '  help                  shows help'
	@echo ''
	@echo 'Extra arguments'
	@echo '  STAGE                 context stage for the command to be run. It can take'
	@echo '                        the values "prod", "dev", or "test". "test" is the'
	@echo '                        default value. This extra argument is available for'
	@echo '                        every make command'
