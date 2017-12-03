IMAGE_NAME = kschwank/bitcoin-abc-qt
CONTAINER_NAME = bitcoin-qt-bch

XSOCK := /tmp/.X11-unix
XAUTH := /tmp/.docker-xauth

image:
	docker build --no-cache -t ${IMAGE_NAME} docker/

run:
	xauth nlist ${DISPLAY} | sed -e 's/^..../ffff/' | xauth -f ${XAUTH} nmerge -
	docker run -ti --rm -e "XAUTHORITY=${XAUTH}" -v ${HOME}/.bitcoin-bch:/bitcoin -v ${XAUTH}:${XAUTH} -v ${XSOCK}:${XSOCK} --name=${CONTAINER_NAME} ${IMAGE_NAME}

clean:
	docker rm ${CONTAINER_NAME}

