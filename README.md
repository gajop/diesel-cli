# diesel-cli Docker container

The image contains [diesel_cli](https://github.com/diesel-rs/diesel/tree/master/diesel_cli) built with postgres support.

# Usage

Images are built automatically with Github Actions.

If you want to build your own docker container, setup `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN` GitHub action secrets upon cloning the repository.

Inspired by https://github.com/clux/diesel-cli, but based on Debian buster instead of musl.

Resulting image is 86.5MB.

I run it with docker-compose, and have it depend on the postgres service being healthy, like so:

```yaml
  db:
    image: postgres
    healthcheck:
      test: [ "CMD-SHELL", "pg_isready -U postgres" ]
      interval: 10s
      timeout: 5s
      retries: 5

  db-migrations:
    image: gajop/diesel-cli
    env_file:
      - ./.env
    volumes:
      - ./migrations:/migrations
    depends_on:
      db:
        condition: service_healthy
    command: diesel migration run
```