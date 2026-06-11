FROM apache/superset:6.1.0

USER root

RUN echo "=== PYTHON ==="
RUN which python || true
RUN python --version || true

RUN echo "=== UV ==="
RUN which uv || true
RUN uv --version || true

RUN echo "=== VENV ==="
RUN ls -la /app/.venv/bin || true

RUN echo "=== ALL UV ==="
RUN find / -name uv 2>/dev/null | head -20
