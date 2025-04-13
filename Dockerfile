FROM node:20-alpine as build

WORKDIR /app

COPY /package*.json ./

RUN npm i

COPY . .

RUN npm run build
FROM node:20-alpine as production
WORKDIR /app
COPY --from=build /app/build ./build
COPY --from=build /app/package.json ./
RUN npm install --omit=dev

COPY ./static ./static
COPY ./other-static-assets ./other-static-assets

EXPOSE 5173

CMD npm run dev
