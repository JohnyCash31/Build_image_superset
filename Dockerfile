FROM apache/superset:6.1.0

USER root

RUN pip install \
    ldap3 \
    psycopg2-binary \
    pymssql \
    Authlib \
    openpyxl \
    Pillow \
    playwright

RUN playwright install-deps && \
    PLAYWRIGHT_BROWSERS_PATH=/usr/local/share/playwright-browsers playwright install chromium

USER superset

CMD ["/app/docker/entrypoints/run-server.sh"]
