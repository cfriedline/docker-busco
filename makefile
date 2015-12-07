TAG=cfriedline/busco

build:
	docker build -t $(TAG) .

shell:
	docker run -v /Users/chris/Downloads:/input  \
	-v /Users/chris/Downloads:/results \
	-it $(TAG) /bin/bash

rm_all:
	docker rm -f `docker ps -q -a`

rmi_all:
	docker rmi -f `docker images -q`
