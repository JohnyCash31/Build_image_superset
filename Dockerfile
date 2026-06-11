FROM apache/superset:master

USER root

ENV PLAYWRIGHT_BROWSERS_PATH=/usr/local/share/playwright-browsers

# Dépendances système nécessaires pour python-ldap
RUN apt-get update && apt-get install -y \
    gcc \
    libldap2-dev \
    libsasl2-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

RUN . /app/.venv/bin/activate && \
    uv pip install \
      psycopg2-binary \
      pymssql \
      Authlib \
      openpyxl \
      Pillow \
      playwright \
      python-ldap && \
    playwright install-deps && \
    playwright install chromium

USER superset

CMD ["/app/docker/entrypoints/run-server.sh"]
