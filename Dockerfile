FROM apache/superset:6.1.0

USER root

RUN . /app/.venv/bin/activate && \
    uv pip install \
      Pillow \
      playwright && \
    playwright install-deps && \
    PLAYWRIGHT_BROWSERS_PATH=/usr/local/share/playwright-browsers playwright install chromium

USER superset

CMD ["/app/docker/entrypoints/run-server.sh"]
