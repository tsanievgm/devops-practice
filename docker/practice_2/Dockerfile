FROM cr.yandex/mirror/python:3.11-slim

WORKDIR /app

ENV REGISTRY="Yandex Mirror"

COPY app.py .

RUN useradd -u 1001 appuser && \
    chown -R 1001:1001 /app


USER 1001

EXPOSE 8080

CMD ["python", "app.py"]
