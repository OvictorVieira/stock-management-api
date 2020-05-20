#!/bin/bash
docker-compose -f docker/docker-compose.yml up -d

docker exec -it stock-management-api bash
