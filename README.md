This set up covers the following:

- Docker
- Configuration as code
- Persistence (SQLite)
- Automatic HTTPS
- Static files

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

- Specify SECRET_KEY using environment variables
    ```diff
    -SECRET_KEY = "django-insecure-@yv*q_)..."
    +SECRET_KEY = os.getenv("MY_SECRET_KEY")
    ```
- Specify ALLOWED_HOSTS (`"*"` is used only for demonstrative purposes)
    ```diff
    -ALLOWED_HOSTS = []
    +ALLOWED_HOSTS = ["*"]
    ```
- Specify STATIC_ROOT
    ```diff
    STATIC_URL = "static/"
    +STATIC_ROOT = "static"
    ```
