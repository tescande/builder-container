SHELL = /bin/bash

IMAGE_NAME = builder
TAG = ubuntu-20.04

DOCKERFILE = Dockerfile.${TAG}

FILES = ${DOCKERFILE} entrypoint.sh

USERNAME = $(shell id -un)
UID = $(shell id -u)
GROUPNAME = $(shell id -gn)
GID = $(shell id -g)

default: image

image: .image_id

.image_id: ${FILES}
	docker build \
		--file ${DOCKERFILE} \
		--tag ${IMAGE_NAME}:${TAG} \
		.
	docker images -q ${IMAGE_NAME}:${TAG} > $@

clean:
	rm -f .image_id
