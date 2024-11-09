# Variables
SERVICE_NAME = frrouting_node
IMAGE_NAME = router_ablaamim

# Targets

# Start the Docker Compose services in detached mode
make:
        docker-compose up -d
        @echo "Docker Compose services started."

# Stop and remove containers, networks, and images created by Docker Compose, then prune unused resources
fclean:
        docker-compose down
        @echo "Docker Compose services stopped and cleaned."
        docker system prune -f
        @echo "Docker system pruned: unused containers, networks, images, and build cache removed."

# Commit the running container as a new image
commit:
        @echo "Starting Docker Compose services for commit..."
        docker-compose up -d
        @echo "Waiting for the container to start..."
        sleep 10
        @echo "Committing container to a new image: $(IMAGE_NAME)"
        docker commit $(SERVICE_NAME) $(IMAGE_NAME)
        docker-compose down
        @echo "Container committed and Docker Compose services stopped."