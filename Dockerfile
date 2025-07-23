FROM python:3.11-slim

ENV PATH="/home/dev/.local/bin:$PATH"
ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH="."

# Pass your UID/GID so files created in the container are owned by you
ARG UID=1000
ARG GID=1000

RUN groupadd -g ${GID} dev \
 && adduser --uid $UID --gid $GID --disabled-password --gecos "" dev \
 && mkdir -p /home/dev/.cache/pip /home/dev/.cache/pip-tools \
 && chown -R dev:dev /home/dev/.cache

USER dev
WORKDIR /app


USER dev

WORKDIR /app

# Speed up installs
ENV PIP_DISABLE_PIP_VERSION_CHECK=1 PIP_NO_CACHE_DIR=1

# Install deps from the pinned lock file
COPY requirements/base.txt requirements/dev.txt ./requirements/
RUN pip install --no-deps --require-hashes -r requirements/dev.txt

# Everything else will be mounted, so nothing more to COPY
CMD ["bash"]
