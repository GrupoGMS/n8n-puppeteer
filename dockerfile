FROM n8nio/n8n:latest

USER root

# Só Chromium (mínimo essencial)
RUN apk add --no-cache chromium

# Só Puppeteer (sem global, sem prefix)
RUN npm install puppeteer

# Variáveis
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

USER node

CMD ["n8n"]