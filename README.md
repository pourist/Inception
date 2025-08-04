## Project: Docker-Based Web Infrastructure

This project implements a secure, containerized web infrastructure using Docker and Docker Compose. The system runs entirely within a virtual machine and is composed of individual services deployed in isolated containers, with persistent storage, internal networking, and TLS-secured external access.

---

## ✅ Infrastructure Overview

The deployed infrastructure includes:

* **NGINX**

  * Acts as the single public entry point
  * Handles HTTPS traffic using **TLSv1.2 and TLSv1.3**
  * Listens exclusively on **port 443**
  * Serves content through reverse proxy to the PHP-FPM backend

* **WordPress**

  * Runs via **PHP-FPM only**, without any embedded web server
  * Manages dynamic content and user interaction
  * Connects internally to a dedicated MariaDB database
  * Site files are mounted via a persistent volume

* **MariaDB**

  * Provides the relational database backend for WordPress
  * Runs in a dedicated container with isolated storage
  * Includes two pre-configured users: one administrator (non-default name) and one regular user
  * All data is stored persistently on disk and isolated from the container lifecycle

---

## ⚙️ Technical Architecture

* All services are orchestrated using **Docker Compose**
* Each service is built from a dedicated **Dockerfile**
* Only minimal base images are used (Alpine or Debian)
* Containers restart automatically upon failure
* A user-defined **Docker bridge network** connects all containers securely
* Two named volumes are used:

  * One for WordPress site files
  * One for MariaDB database storage
* No use of prebuilt images, `latest` tags, or deprecated networking options (`host`, `--link`, etc.)

---

## 🔐 Security & Environment

* Environment variables are stored in a `.env` file
* All secrets (database credentials, user passwords) are stored in a `secrets/` directory
* Secrets are mounted securely into containers via **Docker secrets**
* No sensitive values are hardcoded or committed to version control
* HTTPS is configured with custom certificates, and all communication passes through secure TLS protocols

---

## 🗂️ File Structure

```
Makefile
/secrets
  ├── credentials.txt
  ├── db_password.txt
  ├── db_root_password.txt
  ├── user_credentials.txt
  └── ftp_password.txt
/srcs
  ├── .env
  ├── docker-compose.yml
  └── requirements/
      ├── nginx/
      ├── wordpress/
      ├── mariadb/
      └── bonus/
          ├── redis/
          ├── ftp/
          ├── static-site/
          ├── adminer/
          └── monitor/
```

---

## 🌍 Domain Configuration

The system is accessible via a domain that follows the format `<login>.42.fr`, resolving to the IP of the hosting virtual machine.
**Example:** `ppour-ba.42.fr`

---

## 🧩 Extended Services

Additional containers are implemented to enhance functionality and demonstrate service extensibility:

* **Redis**

  * Provides persistent object caching for WordPress
  * Improves performance by reducing database queries

* **FTP Server**

  * Provides file-level access to WordPress files
  * User credentials handled via Docker secrets
  * Passive ports configured for compatibility

* **Static Website**

  * Independent service hosting a static HTML/JS site (no PHP)
  * Served via a lightweight Alpine-based server

* **Adminer**

  * Lightweight web-based interface to interact with MariaDB
  * Accessible internally for administration and testing

* **Monitor**

  * Lightweight system monitoring service
  * Justified as useful for tracking container status and resource usage

All bonus services are built from Alpine base images and integrated into the Compose network and volume structure. Each is isolated and configured securely.

---

## 📦 Implementation Summary

| Component   | Status      | Description                                      |
| ----------- | ----------- | ------------------------------------------------ |
| Dockerfiles | ✅ Completed | One per service, all Alpine-based                |
| MariaDB     | ✅ Completed | Users, secrets, volumes configured               |
| WordPress   | ✅ Completed | PHP-FPM only, volume-mounted, secrets used       |
| NGINX       | ✅ Completed | TLS reverse proxy, single entry point            |
| Volumes     | ✅ Completed | Persistent data for DB and WordPress             |
| Secrets     | ✅ Completed | Used for all credentials (no plaintext in env)   |
| Networking  | ✅ Completed | User-defined bridge network                      |
| Redis       | ✅ Completed | WordPress object caching via PhpRedis            |
| FTP Server  | ✅ Completed | Secure FTP access to WordPress files via secrets |
| Static Site | ✅ Completed | Pure HTML/JS site served from Alpine container   |
| Adminer     | ✅ Completed | Lightweight DB interface                         |
| Monitor     | ✅ Completed | Bonus utility: live system monitoring service    |

---

## ✅ Completion Statement

This project implements a robust, secure, and modular web infrastructure suitable for deployment, education, and operational demonstration. All mandatory and bonus components have been implemented in strict adherence to the subject’s requirements using best practices in system administration and containerization.


