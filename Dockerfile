# Build Stage
FROM node:16 as BuildStage
WORKDIR /app

COPY src .
COPY package.json .
COPY tsconfig.json .

RUN yarn install
RUN yarn build

FROM node:16-alpine as ReleaseStage
WORKDIR /app

COPY --from=BuildStage /app/dist /app/dist
COPY --from=BuildStage /app/package.json /app/package.json

RUN yarn install --production --no-lockfile

EXPOSE 8080

ARG ENV
ENV Environment ${ENV}

# Entry Point
ENTRYPOINT ["yarn", "start"]
