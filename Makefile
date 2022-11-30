PROJECT_NAME	=	inception

USER			=	ghan

COMPOSE_SOURCE	=	./srcs/docker-compose.yml

VOLUME_PATH		=	/home/$(USER)/data/db \
					/home/$(USER)/data/wp \
					/home/$(USER)/data/am

.PHONY	:	all
all		: 	build
			mkdir -p $(VOLUME_PATH)
			docker-compose -f $(COMPOSE_SOURCE) up

.PHONY	:	build
build	:
			docker-compose -f $(COMPOSE_SOURCE) build

.PHONY	:	clean
clean	:
			docker-compose -f $(COMPOSE_SOURCE) down

.PHONY	:	fclean
fclean:
			docker-compose -f $(COMPOSE_SOURCE) down \
			--remove-orphans --rmi all -v

.PHONY	:	ffclean
ffclean:	fclean
			rm -rf $(VOLUME_PATH)

.PHONY	:	re
re		:	ffclean
			$(MAKE) all