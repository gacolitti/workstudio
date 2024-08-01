docker compose down

# Remove all volumes that begin with "workstudio_"
docker volume ls -q --filter name=workstudio_ | xargs -r docker volume rm

docker compose build
docker compose up -d