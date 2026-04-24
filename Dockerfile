FROM python:3.10-slim

# Установка системных зависимостей
RUN apt-get update && apt-get install -y \
    ffmpeg \
    curl \
    build-essential \
    cargo \
    && rm -rf /var/lib/apt/lists/*

# Установка gifski через cargo
RUN cargo install gifski

# Рабочая директория
WORKDIR /app

# Копируем файлы
COPY . .

# Установка Python зависимостей
RUN pip install --no-cache-dir -r requirements.txt

# Запуск
CMD ["python", "main.py"]