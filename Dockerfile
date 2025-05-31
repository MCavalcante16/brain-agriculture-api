# Estágio de construção
FROM node:18-alpine AS builder

WORKDIR /app

# Instala dependências do sistema
RUN apk add --no-cache openssl

# Copia arquivos de dependência
COPY package.json package-lock.json* ./
COPY prisma ./prisma/

# Instala dependências
RUN npm ci

# Copia todo o código fonte
COPY . .

# Gera o cliente Prisma e builda a aplicação
RUN npx prisma generate
RUN npm run build

# Estágio de produção
FROM node:18-alpine

WORKDIR /app

# Instala dependências de runtime
RUN apk add --no-cache openssl

# Copia apenas o necessário
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/prisma ./prisma

# Porta exposta
EXPOSE 3000

# Comando de inicialização
CMD ["sh", "-c", "npx prisma migrate deploy && npm run start:prod"]