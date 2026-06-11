FROM apache/superset:6.1.0

USER root

RUN apt-get update && apt-get install -y \
    gcc \
    libldap2-dev \
    libsasl2-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip install \
    psycopg2-binary \
    pymssql \
    Authlib \
    openpyxl \
    Pillow \
    playwright \
    python-ldap

RUN playwright install-deps
RUN playwright install chromium

USER superset

CMD ["/app/docker/entrypoints/run-server.sh"]
