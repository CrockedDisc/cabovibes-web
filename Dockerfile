# Etapa 1: Builder
FROM node:18-alpine AS builder

WORKDIR /app

# Copiar solo archivos necesarios para las dependencias
COPY package.json package-lock.json ./

# Instalar dependencias
RUN npm install

# Copiar el resto del proyecto
COPY . .

# Crear build de producción
RUN npm run build

# Etapa 2: Runtime
FROM node:18-alpine AS runner

WORKDIR /app

# Copiar archivos necesarios del builder
COPY --from=builder /app ./

EXPOSE 3000

# Iniciar Next.js
CMD ["npm", "start"]
