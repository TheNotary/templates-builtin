DOCKER_IMAGE_NAME = foo_bar
DTR_DOMAIN = quay.io

build:
	docker build -t ${USER}/${DOCKER_IMAGE_NAME} .

# If you have to configure volumes, do that from here
# configure:

run:
	(docker start ${DOCKER_IMAGE_NAME}) || \
	docker run --name ${DOCKER_IMAGE_NAME} -d ${USER}/${DOCKER_IMAGE_NAME}

console:
	docker run -it \
  -e an_env_var=${HIDDEN_ENV} \
  ${USER}/${DOCKER_IMAGE_NAME} bash

push:
	docker tag ${USER}/${DOCKER_IMAGE_NAME}:experimental ${DTR_DOMAIN}/${USER}/${DOCKER_IMAGE_NAME}:experimental && \
  docker push ${DTR_DOMAIN}/${USER}/${DOCKER_IMAGE_NAME}:experimental

release-tag:
	@if [ -z "${VERSION}" ]; then echo "VERSION is required (X.Y.Z)"; exit 1; fi
	@if ! echo "${VERSION}" | grep -Eq '^[0-9]+\.[0-9]+\.[0-9]+$$'; then echo "VERSION must match X.Y.Z"; exit 1; fi
	git tag -a v${VERSION} -m "Release v${VERSION}"

release-push:
	@if [ -z "${VERSION}" ]; then echo "VERSION is required (X.Y.Z)"; exit 1; fi
	git push origin v${VERSION}

release: release-tag release-push

clean:
	docker stop ${DOCKER_IMAGE_NAME}; \
  docker rm ${DOCKER_IMAGE_NAME}; \
  docker rmi ${USER}/${DOCKER_IMAGE_NAME};

.PHONY: run console build push release-tag release-push release
