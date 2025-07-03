# Inception

A Docker-based infrastructure project that sets up a secure, multi-service web environment. Each service runs in its own container, built from scratch using Dockerfiles, and managed through Docker Compose.

---

## Features

- Custom Dockerfiles for each service (NGINX, WordPress, MariaDB)
- Secure TLS configuration with NGINX (TLSv1.2 or TLSv1.3)
- WordPress served via php-fpm, without a web server in the container
- Persistent storage using Docker volumes
- Environment variables and secrets for secure configuration
- Automated container restarts on failure
- All services connected via a custom Docker network

---

## Directory Structure

```

.
├── Makefile
├── README.md
├── secrets
└── srcs
    ├── docker-compose.yml
    └── requirements
        ├── mariadb
        ├── nginx
        └── wordpress
```

---

## Checklist

### Base Setup

- [x] Project folder structure
- [x] Git initialization and `.gitignore`
- [x] Placeholder Makefile and README

### Environment & Secrets

- [ ] `.env` file for environment variables
- [ ] `secrets/` directory for sensitive values (not committed)

### Services

- [ ] **MariaDB**
  - [ ] Custom Dockerfile
  - [ ] Initialization with root user and database
  - [ ] Volume for persistent data

- [ ] **WordPress (php-fpm)**
  - [ ] Custom Dockerfile
  - [ ] PHP-FPM only, no web server
  - [ ] Connects to MariaDB via env vars
  - [ ] Volume for WordPress files

- [ ] **NGINX**
  - [ ] Custom Dockerfile
  - [ ] HTTPS with TLSv1.2 or TLSv1.3
  - [ ] Reverse proxy to WordPress (php-fpm)
  - [ ] Self-signed certificates

### Orchestration

- [ ] `docker-compose.yml` with all services
- [ ] Named volumes for DB and website files
- [ ] Shared Docker network
- [ ] Restart policies on crash

### Build & Run

- [ ] Makefile to build and run the entire stack

---

## Constraints

- No use of prebuilt service images (except base Alpine/Debian)
- No use of `latest` tag
- No hardcoded passwords in Dockerfiles
- No infinite loops (`tail -f`, `sleep infinity`, etc.)
- No use of `--link`, `network: host`, or legacy networking options

---

```

