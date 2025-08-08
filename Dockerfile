FROM n8nio/n8n:latest

USER root

# Chrome 및 필수 의존성 설치
RUN apk update && apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    fontconfig \
    ttf-freefont \
    dbus \
    xvfb

# n8n 사용자로 전환
USER node

# Puppeteer 환경변수 설정
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser \
    CHROME_BIN=/usr/bin/chromium-browser \
    CHROME_ARGS="--no-sandbox,--disable-setuid-sandbox,--headless,--disable-gpu,--disable-dev-shm-usage,--no-first-run,--no-zygote,--single-process" \
    DISPLAY=:99

EXPOSE 5678
CMD ["n8n", "start"]
