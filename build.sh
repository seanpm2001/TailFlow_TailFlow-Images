docker buildx build --build-arg VERSION=8.0 --push --platform linux/arm64/v8,linux/amd64 --tag tailflow/php:8.0 ./php
docker buildx build --build-arg VERSION=8.1 --push --platform linux/arm64/v8,linux/amd64 --tag tailflow/php:8.1 ./php
