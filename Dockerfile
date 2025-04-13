FROM node:20-alpine AS build
WORKDIR /app
COPY /package*.json ./
RUN npm i
COPY . .
RUN npm run build

FROM node:20-alpine AS production
# Create a non-root user and group
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app
COPY --from=build /app/build ./build
COPY --from=build /app/package.json ./
RUN npm install --omit=dev
COPY ./static ./static
COPY ./other-static-assets ./other-static-assets

# Change ownership of the application files to the non-root user
RUN chown -R appuser:appgroup /app

# Switch to the non-root user
USER appuser

EXPOSE 3000
CMD ["node", "build/index.js"]