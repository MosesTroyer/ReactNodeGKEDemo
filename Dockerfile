FROM node:20 AS build

LABEL maintainer = ["you@example.com"]

# Client / React
WORKDIR /app/client

COPY [ "client/package.json", "client/package-lock.json", "./" ]
COPY client/public/ public
COPY client/src/ src

RUN npm install --omit-dev

COPY ./client .

RUN npm run build

# Server / Node
WORKDIR /app/server

RUN dir -s

COPY [ "server/package.json", "server/package-lock.json", "server/tsconfig.json", "./" ]

RUN npm install --omit-dev

COPY ./server .

RUN npx tsc

# Support / Build files
WORKDIR /app
COPY [ "kustomization.yaml", "deployment.yml", "service.yml", "./" ]

FROM node:20 AS final

COPY --from=build /app/server/dist /app
COPY --from=build /app/server/.env /app
COPY --from=build /app/client/build /app/public
COPY --from=build /app/server/node_modules /app/node_modules

EXPOSE 3008

# Setting environment variables
ENV PORT 3008
ENV NODE_ENV "production"

CMD [ "node", "./app/index.js" ]