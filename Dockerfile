FROM apache/superset:6.1.0

USER root

# ------------------------------------------------------------
# OS deps
# ------------------------------------------------------------
RUN apt-get update && \
    apt-get install -y \
        gcc \
        g++ \
        build-essential \
        python3-dev \
        libldap2-dev \
        libsasl2-dev \
        libssl-dev \
        libffi-dev \
        curl \
        wget && \
    rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------
# IMPORTANT : venv Superset
# ------------------------------------------------------------
ENV VENV_PY=/app/.venv/bin/python

# ------------------------------------------------------------
# Bootstrap pip (FIX TON ERREUR)
# ------------------------------------------------------------
RUN $VENV_PY -m ensurepip --upgrade || true

RUN $VENV_PY -m pip install --no-cache-dir --upgrade \
    pip setuptools wheel

# ------------------------------------------------------------
# Python libs
# ------------------------------------------------------------
RUN $VENV_PY -m pip install --no-cache-dir \
    python-ldap \
    psycopg2-binary \
    pymssql \
    Authlib \
    openpyxl \
    Pillow \
    playwright

# ------------------------------------------------------------
# Playwright
# ------------------------------------------------------------
RUN $VENV_PY -m playwright install-deps

ENV PLAYWRIGHT_BROWSERS_PATH=/usr/local/share/playwright-browsers

RUN $VENV_PY -m playwright install firefox

# ------------------------------------------------------------
# Permissions
# ------------------------------------------------------------
RUN chown -R superset:superset /usr/local/share/playwright-browsers || true

USER superset

CMD ["/app/docker/entrypoints/run-server.sh"]
