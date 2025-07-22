# Inception - Infrastructure Deployment with Docker

## Overview

This project is a comprehensive exercise in infrastructure provisioning using Docker and Docker Compose. The goal is to containerize a set of web services and configure them to run together securely and efficiently in a virtualized environment.

The infrastructure includes NGINX (as a secure entry point), WordPress (as a CMS), and MariaDB (as the database), all containerized and connected via a custom Docker network. The setup emphasizes security, modularity, and compliance with Docker best practices.

---

## Features

### ✅ General Setup

* [ ] Project runs entirely inside a Virtual Machine.
* [ ] All configuration and source files are contained in a `srcs/` directory.
* [ ] A top-level `Makefile` exists and:

  * [ ] Builds all required Docker images.
  * [ ] Uses `docker-compose.yml` to orchestrate containers.

---

### ✅ Docker and System Architecture

* [ ] Each service is built from a custom Dockerfile.
* [ ] No prebuilt images are used (excluding base Alpine or Debian images).
* [ ] Services run in dedicated containers.
* [ ] All images are named after their corresponding services.
* [ ] Containers auto-restart in case of a crash.
* [ ] A custom Docker network is used (no `--link`, `links`, or `network: host`).

---

### ✅ NGINX Configuration

* [ ] A dedicated container runs only NGINX.
* [ ] Only TLSv1.2 or TLSv1.3 is enabled.
* [ ] NGINX is the sole publicly exposed entry point (port 443 only).
* [ ] Forwards incoming HTTPS traffic to WordPress container.

---

### ✅ WordPress Configuration

* [ ] A container runs WordPress with `php-fpm` (no NGINX).
* [ ] Uses a volume to persist WordPress website files.
* [ ] Uses environment variables for configuration (no hardcoded credentials).
* [ ] Uses Docker secrets to store sensitive data (e.g., passwords).
* [ ] Proper domain name mapping (e.g., `yourlogin.42.fr`) pointing to the local IP.

---

### ✅ MariaDB Configuration

* [ ] A container runs only MariaDB (no NGINX).
* [ ] Uses a dedicated volume for database persistence.
* [ ] Includes two database users:

  * [ ] One administrator (not named “admin” or similar).
  * [ ] One regular user.
* [ ] Secure configuration without storing plain credentials.

---

### ✅ Environment and Security

* [ ] Uses a `.env` file to manage environment variables.
* [ ] Docker secrets are used for storing confidential information.
* [ ] No infinite loops or `tail -f`, `sleep`, `bash`, `while true` in `CMD` or `ENTRYPOINT`.
* [ ] Complies with Docker’s PID 1 best practices.
* [ ] The `latest` image tag is not used anywhere.

---

### ✅ Volumes and File Structure

* [ ] WordPress site files are stored in a persistent volume.
* [ ] MariaDB database is stored in a persistent volume.
* [ ] Volumes are mapped to `/home/<login>/data/` on the host machine.
* [ ] Project structure follows the provided directory layout.

---

## Bonus Features

* [ ] Redis caching service configured for WordPress.
* [ ] FTP server container configured to point to the WordPress volume.
* [ ] Static website (non-PHP) hosted in a separate container.
* [ ] Adminer service deployed for database management.
* [ ] A useful custom service added with proper justification during defense.

---

```


