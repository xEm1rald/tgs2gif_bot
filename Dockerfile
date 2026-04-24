FROM python:3.10-slim

RUN apt-get update && apt-get install -y \
    ffmpeg \
    curl \
    build-essential \
    cargo \
    && rm -rf /var/lib/apt/lists/*

# Установка gifski
RUN cargo install gifski

# ВАЖНО
ENV PATH="/root/.cargo/bin:${PATH}"

WORKDIR /app
COPY . .

RUN chmod -R 777 .

RUN pip install --no-cache-dir -r requirements.txt
RUN pip install lottie

CMD ["python", "main.py"]