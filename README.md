This set up covers the following:

- Configuration as code using Docker Compose
- Persistence using SQLite
- Static files serving using uWSGI
- Automatic HTTPS using Caddy

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
- A `.env` file containing `MY_HOSTNAME` and `MY_SECRET_KEY` variables:
    ```
    MY_HOSTNAME=...
    MY_SECRET_KEY=...
    ```
    Generate your secret key like so:
    ```
    from django.core.management.utils import get_random_secret_key
    get_random_secret_key()
    ```
    **DO NOT commit this file to version control!**

Notable changes to `settings.py`:

- Specify `SECRET_KEY` using environment variable
    ```diff
    -SECRET_KEY = "django-insecure-@yv*q_)..."
    +SECRET_KEY = os.getenv("MY_SECRET_KEY", get_random_secret_key())
    ```
- Specify `ALLOWED_HOSTS`
    ```diff
    ALLOWED_HOSTS = []
    +if hostname := os.getenv("MY_HOSTNAME"):
    +    ALLOWED_HOSTS.append(hostname)
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
- Specify `STATIC_ROOT`
    ```diff
    STATIC_URL = "static/"
    +STATIC_ROOT = "static"
    ```

Notes:

- Make sure to go through the [Django deployment checklist](https://docs.djangoproject.com/en/4.0/howto/deployment/checklist/).
