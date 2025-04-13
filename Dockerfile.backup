FROM node:20-alpine AS build

WORKDIR /app

COPY /package*.json ./

RUN npm i

COPY . .

RUN npm run build
FROM node:20-alpine AS production
WORKDIR /app
COPY --from=build /app/build ./build
COPY --from=build /app/package.json ./
RUN npm install --omit=dev

COPY ./static ./static
COPY ./other-static-assets ./other-static-assets

EXPOSE 3000

CMD ["node", "build/index.js"]
