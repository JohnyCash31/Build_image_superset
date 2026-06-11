FROM apache/superset:6.1.0

USER root

# Dépendances système nécessaires à python-ldap
RUN apt-get update && apt-get install -y \
    gcc \
    libldap2-dev \
    libsasl2-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Installation des dépendances Python
RUN python -m pip install --no-cache-dir \
    psycopg2-binary \
    pymssql \
    Authlib \
    openpyxl \
    Pillow \
    python-ldap \
    playwright

# Installation Chromium pour Playwright
RUN playwright install chromium

USER superset

CMD ["/app/docker/entrypoints/run-server.sh"]
