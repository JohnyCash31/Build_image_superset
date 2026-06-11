FROM apache/superset:6.1.0

USER root

ENV PLAYWRIGHT_BROWSERS_PATH=/usr/local/share/playwright-browsers

RUN . /app/.venv/bin/activate && \
    uv pip install \
      psycopg2-binary \
      pymssql \
      Authlib \
      openpyxl \
      Pillow \
      Python-ldap \
      playwright && \
    playwright install-deps && \
    playwright install chromium

USER superset

CMD ["/app/docker/entrypoints/run-server.sh"]
