FROM n8nio/n8n:latest

USER root

# Instala Chromium e dependências
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont

# Configura Puppeteer
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser \
    N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false

# Instala Puppeteer no diretório correto do n8n
RUN cd /usr/local/lib/node_modules/n8n && \
    npm install puppeteer --unsafe-perm=true

# Ajusta permissões
RUN chown -R node:node /usr/local/lib/node_modules/n8n

USER node

WORKDIR /home/node

EXPOSE 5678

# Usa o caminho completo do n8n
CMD ["/usr/local/bin/n8n"]