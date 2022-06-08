FROM holism/vite-dev:latest as builder
WORKDIR /
COPY . .
RUN rm -rf ${RepositoryPath}
COPY /HolismHolding/Infra /HolismHolding/Infra
COPY /HolismVite/Infra /HolismVite/Infra
# https://stackoverflow.com/questions/51115856/docker-failed-to-export-image-failed-to-create-image-failed-to-get-layer
RUN true
COPY ${RepositoryPath} ${RepositoryPath}
RUN true
RUN ln -s /HolismVite/Infra/node_modules ${RepositoryPath}
RUN rm -rf ${RepositoryPath}/.git
RUN mkdir -p ${RepositoryPath}/src
RUN mkdir -p ${RepositoryPath}/src/Base
RUN mkdir -p ${RepositoryPath}/src/Panel
RUN mkdir -p ${RepositoryPath}/src/Components
RUN mkdir -p ${RepositoryPath}/public
RUN cp ${RepositoryPath}/Logo.jsx ${RepositoryPath}/src
RUN cp ${RepositoryPath}/Branding ${RepositoryPath}/Branding
RUN cp ${RepositoryPath}/HeaderActions.jsx ${RepositoryPath}/src
RUN cp ${RepositoryPath}/Menu.jsx ${RepositoryPath}/src
RUN cp ${RepositoryPath}/Routes.jsx ${RepositoryPath}/src
RUN cp /HolismVite/Infra/src/index.css ${RepositoryPath}/src
RUN cp /HolismVite/Infra/src/main.jsx ${RepositoryPath}/src
RUN cp -r /HolismVite/Infra/src/Base ${RepositoryPath}/src
RUN cp -r /HolismVite/Infra/src/Panel ${RepositoryPath}/src
RUN cp -r /HolismVite/Infra/src/Components ${RepositoryPath}/src
RUN cp /HolismVite/Infra/index.html ${RepositoryPath}/index.html
RUN cp /HolismVite/Infra/vite.config.js ${RepositoryPath}
RUN cp /HolismVite/Infra/tailwind.config.jsx ${RepositoryPath}
RUN cp /HolismVite/Infra/package.json ${RepositoryPath}
RUN cp /HolismVite/Infra/postcss.config.jsx ${RepositoryPath}
RUN rm -rf ${RepositoryPath}/src/node_modules
RUN find ${RepositoryPath}
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