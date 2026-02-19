FROM n8nio/n8n:latest

USER root

# Atualiza repositórios
RUN apk update

# Instala dependências do Chromium
RUN apk add --no-cache \
    chromium \
    chromium-chromedriver \
    nss \
    freetype \
    freetype-dev \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    font-noto-emoji \
    nodejs \
    npm

# Instala Puppeteer sem baixar Chromium (usa o do sistema)
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

RUN npm install -g puppeteer --unsafe-perm=true --allow-root

# Cria diretório e ajusta permissões
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/.n8n && \
    chmod 755 /home/node/.n8n

# Volta para usuário node
USER node

# Variável de ambiente para ignorar warning de permissões
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false

EXPOSE 5678

CMD ["n8n"]