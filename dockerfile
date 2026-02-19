FROM n8nio/n8n:latest

USER root

# Instala Chromium e dependências essenciais
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    font-noto-emoji

# Define variáveis de ambiente para Puppeteer
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser \
    CHROME_BIN=/usr/bin/chromium-browser \
    CHROME_PATH=/usr/bin/chromium-browser

# Instala Puppeteer dentro do node_modules global
RUN npm install --prefix /usr/local/lib/node_modules/n8n puppeteer

# Cria link simbólico para que o require funcione
RUN cd /usr/local/lib/node_modules && \
    ln -sf n8n/node_modules/puppeteer puppeteer

# Permissões corretas
RUN chown -R node:node /usr/local/lib/node_modules

# Volta para usuário node
USER node

EXPOSE 5678

# Inicia n8n normalmente
CMD ["n8n"]