# Research Project Title

[![codecov](https://codecov.io/gh/OWNER/reproducible-research-project-template/branch/main/graph/badge.svg)](https://codecov.io/gh/OWNER/reproducible-research-project-template)

## Overview

<!-- TODO: Write a concise description of the project, its goals, and its main components. -->

## Reproduction Steps

<!-- TODO: Describe end‑to‑end steps to reproduce our results:
1. Data acquisition
2. Preprocessing
3. Analysis
4. Evaluation
-->

---

## Environment Setup

This project is fully containerized with Docker to guarantee bit‑for‑bit reproducibility. You can either drive everything from the CLI or hook into your IDE (PyCharm) for an integrated experience. Follow the instructions that match your workflow.

### Prerequisites

* **Docker** (Engine & CLI) installed and running
* **Docker Compose** (if not bundled with Docker)
* A local checkout of this repository

---

### 1. CLI‑Based Workflow

> **Assumes** you have `docker` and `docker-compose` in your `$PATH` and that you’re in the project root.

1. **Build the dev image**

   ```bash
   docker-compose build
   ```

2. **Launch the container**

   ```bash
   docker-compose up -d
   ```

   * Your project directory is bind‑mounted into `/app` inside the container.
   * A persistent pip cache volume speeds up installs.

3. **Run commands inside the container**

   ```bash
   # Open a shell
   docker-compose exec app bash

   # From within: install extras, run tests, start analysis, etc.
   pytest --cov=common --cov-report=term-missing
   # Coverage results will be uploaded to Codecov by the CI pipeline
   python scripts/your_analysis.py --input data/data.parquet --output results/

   # Or exit when you’re done:
   exit
   ```

4. **Stop & clean up**

   ```bash
   docker-compose down
   ```

---

### 2. PyCharm‑Based Workflow

> **Assumes** you’re using PyCharm Professional (with Docker support).

**Add a Docker‑Compose interpreter**

   * **Preferences → Project → Python Interpreter → ⚙️ → Add… → Docker Compose**
   * Select:

     * **Compose file:** `docker-compose.yml`
     * **Service:** `app`
     * **Python interpreter path:** `/usr/local/bin/python3`
   * Click **OK** and let PyCharm probe the container.

---

### 3. Syncing Dependencies (`sync_dependencies.sh`)

Whenever you update your `requirements/*.in` files, you need to recompile them into `.txt`, rebuild your Docker images, and restart the services. Instead of doing these steps by hand, use the provided `sync_dependencies.sh` script:

```bash
# From the project root:
./sync_dependencies.sh
```

This script will:
1. Run `pip-compile` inside the Docker environment to update `requirements/*.txt` (ensuring the correct Python/OS context).
2. Rebuild your Docker Compose images.
3. Redeploy all services (with `--remove-orphans` to clean up any old containers).

After it finishes, your dependencies and containers will be fully up-to-date without manual intervention.

---
This repository uses the following [template](https://github.com/viktor-shcherb/reproducible-research-project-template). See [TEMPLATE.md](TEMPLATE.md) for instructions on customizing the template.
