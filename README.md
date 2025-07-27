# 📘 README

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
  └── user_credentials.txt
/srcs
  ├── .env
  ├── docker-compose.yml
  └── requirements/
      ├── nginx/
      ├── wordpress/
      ├── mariadb/
      └── bonus/
```

---

## 🌍 Domain Configuration

The system is accessible via a domain that follows the format `<login>.42.fr`, resolving to the IP of the hosting virtual machine.
Example: `ppour-ba.42.fr`.

---

## 🧩 Extended Services

Additional containers are implemented to enhance functionality and demonstrate service extensibility:

* **Redis**

  * Provides persistent caching for WordPress
  * Improves performance by reducing database load

* **FTP Server**

  * Allows direct file access to WordPress site files
  * Configured securely to work with Docker volumes

* **Static Website**

  * Separate service hosting a static site (non-PHP)
  * Suitable for a personal resume or project showcase

* **Adminer**

  * Lightweight database management interface
  * Connected to the MariaDB container for internal use

* **Custom Utility Service**

  * Added to fulfill a specific operational or monitoring need
  * Justified as part of the deployment use case

All extended services are built in isolated containers with dedicated Dockerfiles and integrated into the Compose orchestration. Any exposed ports are explicitly declared only when required.

---

## 📦 Implementation Summary

| Component       | Status         | Description                                           |
| --------------- | -------------- | ----------------------------------------------------- |
| Dockerfiles     | ✅ Completed    | One per service, built from Alpine base               |
| MariaDB         | ✅ Completed    | Installed, configured, users created, secrets used    |
| WordPress       | ✅ In progress | PHP-FPM only, volume-mounted files, user provisioning |
| NGINX           | 🚧 Pending     | TLS reverse proxy, port 443, entry point              |
| Volumes         | ✅ Configured   | Two named volumes (DB + site files)                   |
| Secrets         | ✅ Configured   | Secure credentials passed via Docker secrets          |
| Networking      | ✅ Configured   | User-defined bridge network                           |
| Redis           | 🔲 Pending     | For WordPress object cache                            |
| FTP Server      | 🔲 Pending     | Mounted to WordPress volume                           |
| Static Site     | 🔲 Pending     | HTML/CSS/JS hosted separately                         |
| Adminer         | 🔲 Pending     | Internal DB admin tool                                |
| Utility Service | 🔲 Pending     | Custom extension or justification module              |

---

This infrastructure is built with long-term scalability, service separation, and strict security practices in mind, ensuring compliance with modern DevOps and system administration standards.
