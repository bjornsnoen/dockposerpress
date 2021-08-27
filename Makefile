.DEFAULT_GOAL := docker-images

.PHONY: docker-images push

registry := ghcr.io/bjornsnoen
repository := dockposerpress
image := $(registry)/$(repository)

docker-images:
	docker build . --target blog-base-installer -t $(image):installer
	docker build . --target blog-base-runner -t $(image):runner
	docker build . --target blog-base-runner-debug -t $(image):runner-debug

push: docker-images
	docker push $(image):installer
	docker push $(image):runner
	docker push $(image):runner-debug