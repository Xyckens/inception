
up:
	mkdir -p ~/data
	mkdir -p ~/data/mariadb
	mkdir -p ~/data/wordpress

	echo "127.0.0.1 fvieira.42.fr" | sudo tee -a /etc/hosts > /dev/null

	docker-compose -f ./srcs/docker-compose.yml up -d

down:
	docker-compose -f ./srcs/docker-compose.yml down

all: up

# This target ensures all containers are removed if they exist
remove-containers:
	@if [ "$$(docker ps -aq)" ]; then \
		docker rm -f $$(docker ps -aq); \
		docker rmi -f $$(docker images -q) \
	else \
		echo "No containers to remove."; \
	fi

# Update down to include volume removal if needed
down-with-volumes:
	docker-compose -f ./srcs/docker-compose.yml down --volumes

# This target removes images

clean: down-with-volumes remove-containers

fclean: clean
	@sudo rm -rf ~/data
	@docker system prune -a -f

re: fclean all
