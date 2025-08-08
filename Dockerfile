# n8n with Chrome support for Railway
FROM n8nio/n8n:latest

# root 권한으로 Chrome 설치
USER root

# Chrome 및 의존성 설치
RUN apk update && apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    fontconfig \
    ttf-freefont

# n8n 사용자로 돌아가기
USER node

# 작업 디렉토리 설정
WORKDIR /home/node

# Puppeteer 환경변수
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser \
    CHROME_BIN=/usr/bin/chromium-browser \
    CHROME_ARGS="--no-sandbox,--disable-setuid-sandbox,--headless,--disable-gpu,--disable-dev-shm-usage"

# 포트 노출
EXPOSE 5678

# CMD 제거 - 기본 이미지의 시작 명령어 사용
