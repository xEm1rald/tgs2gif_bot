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
RUN chmod -R 777 ./tgs2gif_bot

WORKDIR /app
COPY . .

RUN pip install --no-cache-dir -r requirements.txt
RUN pip install lottie

CMD ["python", "main.py"]