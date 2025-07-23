# Why use this template?
This project template helps you kickstart a fully reproducible research codebase. It integrates Docker for environment parity, dependency pinning via pip-tools, and a pytest setup with Codecov reporting.


## Adding tests for `common`

Create new test modules under `tests/` and import functions from the `common` package. Run them inside the container with:

```bash
pytest --cov=common --cov-report=term-missing
```

CI will publish coverage results to Codecov.

## Writing scripts

Scripts under `scripts/` can be organized with `# %%` cell markers. PyCharm recognizes these cells even when using a Docker interpreter, letting you execute them one block at a time.

## Adding dependencies

1. Add packages to `requirements/base.in` or `requirements/dev.in` as appropriate.
2. Run `./sync_dependencies.sh` to recompile the lock files and rebuild the Docker images.

## Mounting additional volumes

Edit `docker-compose.yml` and add new entries under the `volumes:` section of the `app:` service. Recreate the containers with `docker-compose up -d` to apply the changes.
