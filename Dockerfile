FROM python:3.10-slim

RUN apt-get update && apt-get install -y \
    ffmpeg \
    curl \
    build-essential \
    cargo \
    libcairo2 \
    libgdk-pixbuf2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# gifski
RUN cargo install gifski
ENV PATH="/root/.cargo/bin:${PATH}"

WORKDIR /app
COPY . .

# только нужный chmod
RUN chmod +x lib/linux_amd64/lottie_to_gif.sh

RUN pip install --no-cache-dir -r requirements.txt
RUN pip install lottie

CMD ["python", "main.py"]