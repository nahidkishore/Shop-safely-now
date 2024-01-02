# Stage 1: Build React app
FROM node:16-alpine AS build

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install --force

COPY . .
RUN npm run build

# Stage 2: Serve the app using Node.js server
FROM node:16-alpine

WORKDIR /usr/src/app

COPY --from=build /usr/src/app/build ./build
COPY package*.json ./
RUN npm install -g serve

EXPOSE 3000

CMD ["serve", "-s", "build", "-l", "3000"]
