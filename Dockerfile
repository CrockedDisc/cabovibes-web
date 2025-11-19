# ------------------------------------------------------
# Etapa 1: Build
# ------------------------------------------------------
FROM node:20-alpine AS builder

WORKDIR /app

# Copiar archivos necesarios
COPY package.json package-lock.json ./

# Variables necesarias para el build (Dokploy las inyecta vía Build Arguments)
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

# Exportarlas a entorno para el build
ENV RESEND_API_KEY=$RESEND_API_KEY
ENV NEXT_PUBLIC_SITE_URL=$NEXT_PUBLIC_SITE_URL
ENV NEXT_PUBLIC_SANITY_PROJECT_ID=$NEXT_PUBLIC_SANITY_PROJECT_ID
ENV NEXT_PUBLIC_SANITY_DATASET=$NEXT_PUBLIC_SANITY_DATASET
ENV SANITY_API_TOKEN=$SANITY_API_TOKEN
ENV SANITY_WEBHOOK_SECRET=$SANITY_WEBHOOK_SECRET
ENV PAYPAL_CLIENT_ID=$PAYPAL_CLIENT_ID
ENV PAYPAL_CLIENT_SECRET=$PAYPAL_CLIENT_SECRET
ENV NEXT_PUBLIC_PAYPAL_CLIENT_ID=$NEXT_PUBLIC_PAYPAL_CLIENT_ID
ENV PAYPAL_MODE=$PAYPAL_MODE
ENV DATABASE_URL=$DATABASE_URL
ENV DATABASE_URL_DIRECT=$DATABASE_URL_DIRECT
ENV DATABASE_URL_SESSION=$DATABASE_URL_SESSION

# Instalar dependencias
RUN npm install

# Copiar el resto del proyecto
COPY . .

# Generar build (output standalone)
RUN npm run build

# ------------------------------------------------------
# Etapa 2: Runtime
# ------------------------------------------------------
FROM node:20-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production
ENV PORT=3000
ENV HOSTNAME=0.0.0.0

# Copiar standalone optimizado
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/static ./.next/static

# Asegurar que server.js esté en el contenedor
COPY server.js .

EXPOSE 3000

# Ejecutar Next.js standalone
CMD ["node", "server.js"]
