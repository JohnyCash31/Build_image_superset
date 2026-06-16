FROM apache/superset:6.1.0

USER root

RUN apt-get update && \
    apt-get install -y \
        gcc \
        g++ \
        build-essential \
        python3-dev \
        libldap2-dev \
        libsasl2-dev \
        libssl-dev && \
    rm -rf /var/lib/apt/lists/*

RUN pip install \
    python-ldap \
    psycopg2-binary \
    pymssql \
    Authlib \
    openpyxl \
    Pillow \
    playwright

RUN playwright install-deps && \
    PLAYWRIGHT_BROWSERS_PATH=/usr/local/share/playwright-browsers \
    playwright install firefox

USER superset

CMD ["/app/docker/entrypoints/run-server.sh"]
