
### ✅ **General Setup**

* [ ] Create a Linux **Virtual Machine**.
* [ ] Install **Docker** and **Docker Compose**.
* [ ] Create the `srcs` folder.
* [ ] Create the **Makefile** at the root of the project.
* [ ] All config files must go inside the `srcs` directory.
* [ ] Avoid using `tail -f`, `sleep infinity`, or `while true` in Docker containers.
* [ ] Use only the **penultimate stable** version of **Alpine** or **Debian** as base images.

---

### ✅ **Environment Configuration**

* [ ] Create a `.env` file in `srcs/` for environment variables.
* [ ] Store secrets in a `secrets/` directory (e.g., credentials, DB passwords).
* [ ] Use **Docker secrets** to manage sensitive information.
* [ ] Exclude `.env` and `secrets/` files from Git versioning.

---

### ✅ **Docker Infrastructure**

* [ ] Use **Docker Compose** to define and orchestrate services.
* [ ] Each service must have its **own Dockerfile**.
* [ ] Each service must run in a **dedicated container**.
* [ ] Image name must match the service name.
* [ ] Do **not** use `network: host`, `--link`, or `links:`.
* [ ] Use a custom **Docker network** (defined in `docker-compose.yml`).
* [ ] Containers must **restart automatically** on failure.

---

### ✅ **Mandatory Services**

#### 🔹 **NGINX**

* [ ] Use **TLSv1.2 or TLSv1.3 only**.
* [ ] Accessible **only through port 443**.
* [ ] Set up NGINX as the **sole entry point**.
* [ ] Configure SSL with self-signed certificate.

#### 🔹 **MariaDB**

* [ ] No NGINX here.
* [ ] Store data in a **named volume**.
* [ ] Use environment variables for user/pass.
* [ ] Must include at least **2 users**, one **non-'admin' named administrator**.

#### 🔹 **WordPress (with php-fpm)**

* [ ] No NGINX in this container.
* [ ] Store WordPress **site files in a volume**.
* [ ] Use `php-fpm` only (no Apache).
* [ ] Connect to MariaDB via internal Docker network.

---

### ✅ **Volumes**

* [ ] 1 volume for **WordPress database**.
* [ ] 1 volume for **WordPress files**.
* [ ] Located under `/home/<login>/data`.

---

### ✅ **Domain Setup**

* [ ] Domain name should be `<login>.42.fr`.
* [ ] Resolve it locally to your VM IP address (via `/etc/hosts` or DNS).

---

### ✅ **Security and Best Practices**

* [ ] Do not expose any **credentials** in Dockerfiles.
* [ ] Use `.env` and Docker secrets for configuration.
* [ ] Do not use the `latest` tag in Dockerfiles.
* [ ] Read about **PID 1 behavior** in containers and write clean Dockerfiles.

---

### ✅ **Bonus (Only If Mandatory Is Perfect)**

* [ ] Add **Redis** for WordPress caching.
* [ ] Add a **FTP server** for WP file access.
* [ ] Add a **static website** (not in PHP).
* [ ] Add **Adminer** for DB management.
* [ ] Add a **custom service** and justify its purpose.

---

### ✅ **Submission**

* [ ] Push only your repo contents (Makefile, `srcs/`, `secrets/`).
* [ ] Double-check file/folder names.
* [ ] Ready for peer evaluation.

---

Once you confirm, we’ll proceed with step 1: **setting up the project structure**.
