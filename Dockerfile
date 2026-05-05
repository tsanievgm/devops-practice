FROM python:3.11-slim

LABEL maintainer="Gamzat"
LABEL description="Тестовое приложение на Flask"
LABEL version="1.0.0"

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV APP_VERSION=1.0.0
ENV ENVIRONMENT=stage
ENV STUDENT_NAME=Gamzat

COPY requirements.txt .

RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc && \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    apt-get purge -y --auto-remove gcc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


COPY . .

RUN useradd -u 1001 appuser && \
    chown -R 1001:1001 /app
USER 1001

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8080/health')" || exit 1

CMD ["python", "app.py"]

