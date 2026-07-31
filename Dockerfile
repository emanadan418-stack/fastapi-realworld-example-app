FROM python:3.9-slim

WORKDIR /app

# Install system deps (important for cryptography, etc.)
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

COPY pyproject.toml poetry.lock ./

RUN pip install --upgrade pip && \
    pip install poetry==1.8.3 && \
    poetry config virtualenvs.create false && \
    poetry install --no-root --no-dev

COPY . .

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]