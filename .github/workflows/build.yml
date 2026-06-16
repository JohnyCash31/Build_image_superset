FROM apache/superset:6.1.0

USER root

# ------------------------------------------------------------
# Dépendances système nécessaires aux libs Python
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
# Installation Python (IMPORTANT : via python -m pip)
# ------------------------------------------------------------
RUN python -m pip install --no-cache-dir --upgrade pip setuptools wheel

RUN python -m pip install --no-cache-dir \
    python-ldap \
    psycopg2-binary \
    pymssql \
    Authlib \
    openpyxl \
    Pillow \
    playwright

# ------------------------------------------------------------
# Playwright setup (browsers + deps)
# ------------------------------------------------------------
RUN python -m playwright install-deps

ENV PLAYWRIGHT_BROWSERS_PATH=/usr/local/share/playwright-browsers

RUN python -m playwright install firefox

# ------------------------------------------------------------
# Permissions (important pour Superset runtime)
# ------------------------------------------------------------
RUN chown -R superset:superset /usr/local/share/playwright-browsers || true

# ------------------------------------------------------------
# Retour user non-root (obligatoire Superset)
# ------------------------------------------------------------
USER superset

# ------------------------------------------------------------
# Lancement Superset
# ------------------------------------------------------------
CMD ["/app/docker/entrypoints/run-server.sh"]
