NAME = inception
COMPOSE = docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env
SETUP_SCRIPT = srcs/requirements/wordpress/tools/docker-entrypoint.sh
DATA_PATH = /home/$(USER)/data

all:
	@echo "🚀 Launching $(NAME)..."
	@mkdir -p $(DATA_PATH)/wordpress $(DATA_PATH)/mariadb
	@$(COMPOSE) up -d

build:
	@echo "🔨 Building $(NAME)..."
	@mkdir -p $(DATA_PATH)/wordpress $(DATA_PATH)/mariadb
	@$(COMPOSE) up -d --build

down:
	@echo "🛑 Stopping $(NAME)..."
	@$(COMPOSE) down

re: down
	@echo "🔁 Rebuilding $(NAME)..."
	@$(COMPOSE) up -d --build

clean: down
	@echo "🧹 Cleaning volumes and data..."
	@docker system prune -a --force
	@sudo rm -rf $(DATA_PATH)/wordpress
	@sudo rm -rf $(DATA_PATH)/mariadb

fclean:
	@echo "💥 Full clean of Docker environment..."
	@docker stop $$(docker ps -qa) || true
	@docker system prune -a --volumes --force
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf $(DATA_PATH)/wordpress
	@sudo rm -rf $(DATA_PATH)/mariadb

.PHONY: all build down re clean fclean
