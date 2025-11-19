# ------------------------------------------------------
# Etapa 1: Builder
# ------------------------------------------------------
FROM node:20-alpine AS builder

WORKDIR /app

# Copiar package.json + lock para instalación correcta
COPY package.json package-lock.json ./

# Instalar dependencias (IMPORTANTE: no ignores devDeps)
RUN npm install

# Copiar el resto del código
COPY . .

# Variables Build ARG
ARG RESEND_API_KEY
ARG NEXT_PUBLIC_SITE_URL
ARG NEXT_PUBLIC_SANITY_PROJECT_ID
ARG NEXT_PUBLIC_SANITY_DATASET
ARG SANITY_API_TOKEN
ARG SANITY_WEBHOOK_SECRET
ARG PAYPAL_CLIENT_ID
ARG PAYPAL_CLIENT_SECRET
ARG NEXT_PUBLIC_PAYPAL_CLIENT_ID
ARG PAYPAL_MODE
ARG DATABASE_URL
ARG DATABASE_URL_DIRECT
ARG DATABASE_URL_SESSION

# Construir Next.js con standalone
RUN npm run build

# ------------------------------------------------------
# Etapa 2: Runner
# ------------------------------------------------------
FROM node:20-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production
ENV PORT=3000

# Copiar .next/standalone (contiene node_modules necesarios)
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/static ./.next/static

EXPOSE 3000

CMD ["node", "server.js"]
