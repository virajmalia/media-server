# Media Server Documentation

## Overview

This media server is designed to run a variety of services, including:
- Immich Server: a photo and video sharing platform
- Immich Machine Learning: a machine learning model for image and video processing
- Redis: an in-memory data store
- PostgreSQL: a relational database
- Plex: a media management and streaming platform
- Nginx: a web server and reverse proxy

## Services

### 1. Immich Server

* Container Name: `immich_server`
* Environment Variables:
	+ `UPLOAD_LOCATION`: the location of media files on the host machine (default: `./immich/library`)
	+ `EXTERNAL_LIB`: a library path for external media

### 2. Immich Machine Learning

* Container Name: `immich_machine_learning`
* Environment Variables:
	+ `UPLOAD_LOCATION`: the location of media files on the host machine

### 3. Redis

* Container Name: `immich_redis`

### 4. PostgreSQL

* Container Name: `immich_postgres`
* Environment Variables:
	+ `POSTGRES_PASSWORD`: your database password (default: `postgres`)
	+ `POSTGRES_USER`: your database username (default: `postgres`)
	+ `POSTGRES_DB`: your database name (default: `immich`)

### 5. Plex

* Container Name: `plex`
* Environment Variables:
	+ `PUID`: the user ID for Plex to run as
	+ `PGID`: the group ID for Plex to run as
	+ `TZ`: the timezone for Plex to use
	+ `PLEX_CLAIM_TOKEN`: your Plex server claim token (replace with your own token)

### 6. Nginx

* Container Name: `nginx`
* Ports:
	+ `80:80`
	+ `443:443`

## Volumes

The following volumes are mounted:

* `model-cache`: a cache directory for model storage
* `/etc/localtime:/etc/localtime:ro`: syncs the container's time with the host's time
* `/var/lib/postgresql/data`: mounts the database storage directory
* `./plexmediaserver`: mounts the Plex server application data directory
* `./ssl`: mounts the SSL certificate and key files

## Running the Media Server

To run the media server, navigate to the `media-server` directory in your terminal and run the following command:

```bash
docker-compose up -d
```

This will start all containers in detached mode. You can view the logs for each container using the following command:

```bash
docker-compose logs --follow <container_name>
```

Replace `<container_name>` with the name of the container you want to view the logs for.

## Notes

* Make sure to replace `postgres` with a secure password for PostgreSQL.
* Update `PLEX_CLAIM_TOKEN` with your own Plex server claim token.
