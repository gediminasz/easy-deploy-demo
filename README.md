This set up covers the following:

- Configuration as code using Docker Compose
- Persistence using SQLite
- Static files serving using uWSGI
- Automatic HTTPS using Traefik

Prerequisites:

- A server with Docker installed
- A domain address pointing to that server
- SSH config such that `ssh demo` works, e.g.:
    ```
    Host demo
        HostName 1.2.3.4
        User root
        IdentityFile ~/.ssh/id_rsa
    ```

Notable changes to `settings.py`:

- Specify SECRET_KEY using environment variable
    ```diff
    -SECRET_KEY = "django-insecure-@yv*q_)..."
    +SECRET_KEY = os.getenv("MY_SECRET_KEY")
    ```
- Specify ALLOWED_HOSTS (`"*"` is used only for demonstrative purposes)
    ```diff
    -ALLOWED_HOSTS = []
    +ALLOWED_HOSTS = ["*"]
    ```
- Specify database location using environment variable
    ```diff
    DATABASES = {
        "default": {
            "ENGINE": "django.db.backends.sqlite3",
    -       "NAME": BASE_DIR / "db.sqlite3",
    +       "NAME": Path(os.getenv("MY_STORAGE_DIR", BASE_DIR)) / "db.sqlite3",
        }
    }
    ```
- Specify STATIC_ROOT
    ```diff
    STATIC_URL = "static/"
    +STATIC_ROOT = "static"
    ```
