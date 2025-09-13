# Media Server Documentation

## Overview

This media server is designed to run a variety of services, including:
- Immich Server: a photo and video sharing platform
- Immich Machine Learning: a machine learning model for image and video processing
- Redis: an in-memory data store
- PostgreSQL: a relational database
- Duplicati: a backup management solution
- Plex: a media management and streaming platform
- Nginx: a web server and reverse proxy

## Services

### 1. Immich Server

* Container Name: `immich_server`
* Environment Variables:
	+ `IMMICH_VERSION`: Immich version
	+ `UPLOAD_LOCATION`: the location of media files on the host machine (default: `./immich/library`)
	+ `EXTERNAL_LIB`: a library path for external media
	+ `UPLOAD_LOCATION`: the location of media files on the host machine

### 2. Immich Machine Learning

* Container Name: `immich_machine_learning`

### 3. Redis

* Container Name: `immich_redis`

### 4. PostgreSQL

* Container Name: `immich_postgres`
* Environment Variables:
	+ `DB_PASSWORD`: your database password (default: `postgres`)
	+ `DB_USERNAME`: your database username (default: `postgres`)
	+ `DB_NAME`: your database name (default: `immich`)
	+ `DB_DATA_LOCATION`: host location of your database

### 5. Plex

* Container Name: `plex`
* Environment Variables:
	+ `PLEX_VERSION`: Plex version
	+ `PUID`: the user ID for Plex to run as
	+ `PGID`: the group ID for Plex to run as
	+ `TZ`: the timezone for Plex to use
	+ `PLEX_CLAIM_TOKEN`: your Plex server claim token (replace with your own token)

### 6. Nginx

* Container Name: `nginx`
* Environment Variables:
	+ `NGINX_VERSION`: nginx version
* Ports:
	+ `80:80`
	+ `443:443`
* Nginx reverse proxy is setup to expose the media services outside the home network using the public IP of the host. By default this is setup using `http` which is insecure.
* There are many ways to setup `SSL/https`. Place SSL `key.pem` and `cert.pem` in `./data/ssl` folder. If you own a custom domain, cloudflare is the simplest and most secure option if setup correctly; even better if a tunnel is used.

## Volumes

The following volumes are mounted:

* `model-cache`: a cache directory for model storage
* `/etc/localtime:/etc/localtime:ro`: syncs the container's time with the host's time
* `./data/immich/library`: Immich upload library storage
* `./data/immich/postgres`: Immich postgres database storage
* `./data/plexmediaserver`: mounts the Plex server application data directory
* `./data/ssl`: mounts the SSL certificate and key files
* `./data/duplicati`: Duplicati working directory

## Running the Media Server

To run the media server, navigate to the `media-server` directory in your terminal and run the following command:

```bash
sudo docker compose up -d
```

This will start all containers in detached mode. You can view the logs for each container using the following command:

```bash
sudo docker compose logs --follow <container_name>
```

Replace `<container_name>` with the name of the container you want to view the logs for. If it is not specified, logs from all containers will be shown.

To stop the media server, run the command:

```bash
sudo docker compose down
```

## Hardware Acceleration

- The `hwaccel.*.yml` files contain docker configurations for hardware acceleration using `openvino` for Intel CPUs, and `cuda` for nvidia GPUs, for Immich.
- The `docker-compose.yml` uses `openvino` by default.
- HW acceleration in Plex can be enabled from the web interface.

## Notes

* Copy `sample-configs/.env` into the root of this project (same location as `docker-compose.yml`).
* Update all placeholder variables with your own values.
* Make sure to replace `postgres` with a secure password for PostgreSQL.
* For individual services, refer to their docker-compose documentations for more options.
