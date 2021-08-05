FROM holism/react-dev:latest as builder
COPY /HolismHolding/Infra /HolismHolding/Infra
COPY /HolismReact/Infra /HolismReact/Infra
COPY ${RepositoryPath} ${RepositoryPath}
COPY --from=dependencies /HolismHolding/Infra/node_modules ${RepositoryPath}/node_modules
RUN cp -a /HolismReact/Infra/. ${RepositoryPath}
WORKDIR ${RepositoryPath}
RUN npm run build

FROM node:lts-alpine as runner
WORKDIR ${RepositoryPath}
ENV NODE_ENV production
RUN npm install -g serve
COPY --from=builder ${RepositoryPath}/build ./build

EXPOSE 3000
CMD [ "serve", "-s", "build", "-l", "3000" ]