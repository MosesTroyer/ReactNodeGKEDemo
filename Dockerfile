FROM node:20 AS build

LABEL maintainer = ["you@example.com"]

# Client / React
WORKDIR /app/client

COPY [ "client/package.json", "client/package-lock.json", "client/tsconfig.json", "./" ]
COPY client/public/ public
COPY client/src/ src

RUN npm install --omit-dev

RUN npm run build

# Server / Node
WORKDIR /app/server

COPY [ "server/package.json", "server/package-lock.json", "server/tsconfig.json", "server/.env", "./" ]
COPY server/src/ src

RUN npm install --omit-dev

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