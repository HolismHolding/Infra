FROM holism/react-dev:latest as builder
WORKDIR /
COPY . .
RUN rm -rf ${RepositoryPath}
COPY /HolismHolding/Infra /HolismHolding/Infra
COPY /HolismReact/Infra /HolismReact/Infra
# https://stackoverflow.com/questions/51115856/docker-failed-to-export-image-failed-to-create-image-failed-to-get-layer
RUN true
COPY ${RepositoryPath} ${RepositoryPath}
RUN true
RUN ln -s /HolismReact/Infra/node_modules ${RepositoryPath}
RUN rm -rf ${RepositoryPath}/.git \
    && mkdir -p /Temp \
    && cp -a ${RepositoryPath}/. /Temp \
    && mkdir -p ${RepositoryPath}/src/${Repository} \
    && cp -a /Temp/. ${RepositoryPath}/src/${Repository} \
    && mkdir -p ${RepositoryPath}/src \
    && mkdir -p ${RepositoryPath}/src/Base \
    && mkdir -p ${RepositoryPath}/src/Panel \
    && mkdir -p ${RepositoryPath}/src/Components \
    && mkdir -p ${RepositoryPath}/src/public \
    && cp ${RepositoryPath}/Logo.js ${RepositoryPath}/src \
    && cp ${RepositoryPath}/Favicon.ico ${RepositoryPath}/public/favicon.ico \
    && cp ${RepositoryPath}/HeaderActions.js ${RepositoryPath}/src \
    && cp ${RepositoryPath}/Menu.js ${RepositoryPath}/src \
    && cp ${RepositoryPath}/Routes.js ${RepositoryPath}/src \
    && cp /HolismReact/Infra/src/index.css ${RepositoryPath}/src \
    && cp /HolismReact/Infra/src/index.js ${RepositoryPath}/src \
    && cp -r /HolismReact/Infra/src/Base ${RepositoryPath}/src \
    && cp -r /HolismReact/Infra/src/Panel ${RepositoryPath}/src \
    && cp -r /HolismReact/Infra/src/Components ${RepositoryPath}/src \
    && cp -r /HolismReact/Infra/public ${RepositoryPath}/public \
    && cp /HolismReact/Infra/craco.config.js ${RepositoryPath} \
    && cp /HolismReact/Infra/tailwind.config.js ${RepositoryPath} \
    && cp /HolismReact/Infra/package.json ${RepositoryPath} \
    && cp /HolismReact/Infra/package-lock.json ${RepositoryPath}
#RUN find ${RepositoryPath}
WORKDIR ${RepositoryPath}
RUN npm run build

FROM node:lts-alpine as runner
WORKDIR ${RepositoryPath}
ENV NODE_ENV production
RUN npm install -g serve
COPY --from=builder ${RepositoryPath}/build .

EXPOSE 3000
CMD [ "serve", "-s", ".", "-l", "3000" ]
# CMD [ "tail", "-f", "/dev/null" ]