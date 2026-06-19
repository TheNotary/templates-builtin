DOCKER_IMAGE_PATH = FOO_IMAGE_PATH
DOCKER_IMAGE_NAME = foo_bar
DTR_DOMAIN = quay.io

build:
	docker build -t ${DOCKER_IMAGE_PATH} .

# If you have to configure volumes, do that from here
# configure:

run:
	(docker start ${DOCKER_IMAGE_NAME}) || \
	docker run --name ${DOCKER_IMAGE_NAME} -d ${DOCKER_IMAGE_PATH}

console:
	docker run -it \
  -e an_env_var=${HIDDEN_ENV} \
  ${DOCKER_IMAGE_PATH} bash

push:
	docker tag ${DOCKER_IMAGE_PATH}:experimental ${DTR_DOMAIN}/${DOCKER_IMAGE_PATH}:experimental && \
  docker push ${DTR_DOMAIN}/${DOCKER_IMAGE_PATH}:experimental

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
  docker rmi ${DOCKER_IMAGE_PATH};

.PHONY: run console build push release-tag release-push release
