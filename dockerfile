FROM n8nio/n8n:latest

USER root

# Instala APENAS Chromium e dependências (SEM nodejs/npm)
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont

# Configura Puppeteer para usar Chromium do sistema
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Instala Puppeteer usando o npm que JÁ EXISTE na imagem
RUN npm install -g puppeteer --unsafe-perm=true

# Ajusta permissões
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/.n8n

# Volta para usuário node
USER node

# Ignora warning de permissões
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false

EXPOSE 5678

# Comando original do n8n (que já existe!)
CMD ["n8n"]