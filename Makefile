images:
	sudo docker build \
		-t silverstripe-httpd \
		-f httpd.dockerfile \
		--build-arg MY_UID=$$(id -u) \
		--build-arg MY_GID=$$(id -g) \
		.
	sudo docker build \
		-t silverstripe-db \
		-f db.dockerfile \
		--build-arg MY_UID=$$(id -u) \
		--build-arg MY_GID=$$(id -g) \
		.

project:
	sudo docker run --rm --interactive --tty \
		--user $$(id -u):$$(id -g) \
		--volume $$(pwd)/src:/app \
		composer --ignore-platform-req=ext-intl create-project silverstripe/installer html
	cp httpd/ss.env.sh src/html/.env

clean:
	rm -r $$(pwd)/src/html ; true
	rm -r $$(pwd)/db/* ; true
	sudo docker kill ss ; true
	sudo docker kill db ; true
	sudo docker rmi silverstripe-httpd ; true
	sudo docker rmi silverstripe-db ; true

containers:
	sudo docker-compose up