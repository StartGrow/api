FROM node:latest

ENV CHROME_BIN=/usr/bin/chromium \
    TZ=Asia/Jakarta \
    DEBIAN_FRONTEND=noninteractive

# Install Chromium dan dependensinya
RUN apt-get update && apt-get install -y \
    chromium \
    ffmpeg \
    imagemagick \
    libnss3-dev \
    webp \
    gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 \
    libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
    libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 \
    libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
    ca-certificates libappindicator1 libnss3 lsb-release xdg-utils \
    fonts-liberation fonts-dejavu fonts-noto-color-emoji libfontconfig1 --no-install-recommends \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set workdir
WORKDIR /app

# Salin package.json dan install depensi
COPY package*.json ./
RUN npm install \
 && npx playwright install --with-deps

# Salin source code
COPY . .

# Buka port untuk akses
EXPOSE 7860

# Jalankan server
CMD ["node", "."]
