FROM holism/vite-dev:latest as builder
WORKDIR /
COPY . .
RUN rm -rf ${RepositoryPath}
COPY /HolismHolding/Infra /HolismHolding/Infra
COPY /HolismVite/Infra /HolismVite/Infra
# https://stackoverflow.com/questions/51115856/docker-failed-to-export-image-failed-to-create-image-failed-to-get-layer
RUN true
COPY ${RepositoryPath} /Temp
RUN true
RUN mkdir -p ${RepositoryPath}
RUN ln -s /HolismVite/Infra/node_modules ${RepositoryPath}
RUN rm -rf /Temp/.git
RUN rm -rf /Temp/.gitignore
RUN rm -rf /Temp/.github
RUN rm -rf /Temp/Host
RUN rm -rf /Temp/Dependencies
RUN mkdir -p ${RepositoryPath}/src
RUN mkdir -p ${RepositoryPath}/src/Base
RUN mkdir -p ${RepositoryPath}/src/Panel
RUN mkdir -p ${RepositoryPath}/src/Components
RUN mv /Temp/.env ${RepositoryPath}
RUN mv /Temp/.env.production ${RepositoryPath}
RUN mv /Temp/HeaderActions.jsx ${RepositoryPath}/src
RUN mv /Temp/Logo.jsx ${RepositoryPath}/src
RUN mv /Temp/Menu.jsx ${RepositoryPath}/src
RUN mv /Temp/Routes.jsx ${RepositoryPath}/src
RUN mv /Temp/Branding ${RepositoryPath}/src/Branding
RUN mv /HolismVite/Infra/src/index.css ${RepositoryPath}/src
RUN mv /HolismVite/Infra/src/main.jsx ${RepositoryPath}/src
RUN mv /HolismVite/Infra/src/Base ${RepositoryPath}/src
RUN mv /HolismVite/Infra/src/Panel ${RepositoryPath}/src
RUN mv /HolismVite/Infra/src/Components ${RepositoryPath}/src
RUN mv /HolismVite/Infra/index.html ${RepositoryPath}/index.html
RUN mv /HolismVite/Infra/vite.config.js ${RepositoryPath}
RUN mv /HolismVite/Infra/tailwind.config.js ${RepositoryPath}
RUN mv /HolismVite/Infra/package.json ${RepositoryPath}
RUN mv /HolismVite/Infra/postcss.config.js ${RepositoryPath}
RUN mv /Temp/* ${RepositoryPath}/src
RUN find /Temp -maxdepth 1 | sort
RUN find ${RepositoryPath} | sort
RUN ls ${RepositoryPath} -lah
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