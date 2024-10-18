
vol:
	sudo mkdir -p ~/data
	sudo mkdir -p ~/data/mariadb
	sudo mkdir -p ~/data/wordpress

up2:
	docker-compose -f ./srcs/docker-compose.yml up -d

down:
	docker-compose -f ./srcs/docker-compose.yml down

all: vol up2

# This target ensures all containers are removed if they exist
remove-containers:
	@if [ "$$(docker ps -aq)" ]; then \
		docker rm -f $$(docker ps -aq); \
	else \
		echo "No containers to remove."; \
	fi

# Update down to include volume removal if needed
down-with-volumes:
	docker-compose -f ./srcs/docker-compose.yml down --volumes

# This target removes images
rm-image:
	docker rmi -f $$(docker images -q)

clean: down remove-containers rm-image

fclean: clean
	@sudo rm -rf ~/data
	@docker system prune -a -f

re: fclean all
