# Media Server Documentation

## Overview

This media server is designed to run a variety of services as listed below.

## Services

### 1. Immich Server

* Service type: Photo and Video management solution
* Container Name: `immich_server`
* Environment Variables:
	+ `IMMICH_VERSION`: Immich version
	+ `EXTERNAL_LIB`: the location of external media
	+ `UPLOAD_LOCATION`: the location of uploaded files

### 2. Immich Machine Learning

* Service type: ML for Immich
* Container Name: `immich_machine_learning`

### 3. Redis

* Service type: Queuing database for Immich
* Container Name: `immich_redis`

### 4. PostgreSQL

* Service type: Resting database for Immich
* Container Name: `immich_postgres`
* Environment Variables:
	+ `DB_PASSWORD`: your database password (default: `postgres`)
	+ `DB_USERNAME`: your database username (default: `postgres`)
	+ `DB_NAME`: your database name (default: `immich`)
	+ `DB_DATA_LOCATION`: host location of your database

### 5. Jellyfin

* Service type: Media Steaming solution
* Container Name: `jellyfin`
* Environment Variables:
	+ `STREAM_EXT_LIB`: Location of your streaming media

### 6. Duplicati

* Service type: Data backup solution
* Container Name: `duplicati`
* Environment Variables:
	+ `SETTINGS_ENCRYPTION_KEY`: your encryption/decryption password. This key is used to encrypt and decrypt your backups so keep this safe off-site
	+ `DUPLICATI__WEBSERVICE_PASSWORD`: password for the Duplicati WebUI login

### 7. Nginx

* Service type: Reverse proxy
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

* `./data/immich/library`: Immich upload library storage
* `./data/immich/postgres`: Immich postgres database storage
* `./data/jellyfin`: mounts the Jellyfin server data directory
* `./data/duplicati`: Duplicati working directory
* `./data/ssl`: mounts the SSL certificate and key files
* `model-cache`: a cache directory for model storage
* `/etc/localtime:/etc/localtime:ro`: syncs the container's time with the host's time

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
- The `compose.yaml` uses `openvino` by default.

## Notes

* Copy `sample-configs/.env` into the root of this project (same location as `compose.yaml`).
* Update all placeholder variables with your own values.
* Make sure to replace `postgres` with a secure password for PostgreSQL.
* For individual services, refer to their docker-compose documentations for more options.
