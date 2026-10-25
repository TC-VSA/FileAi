FROM node:20-alpine
WORKDIR /app
COPY . .
RUN npm run validate
EXPOSE 4173
CMD ["node","scripts/server.mjs","--dist"]
