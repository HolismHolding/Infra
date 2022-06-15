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
Run mkdir -p ${RepositoryPath} \
    && ln -s /HolismVite/Infra/node_modules ${RepositoryPath} \
    && rm -rf /Temp/.git \
    && rm -rf /Temp/.gitignore \
    && rm -rf /Temp/.github \
    && rm -rf /Temp/Host \
    && rm -rf /Temp/Dependencies \
    && mkdir -p ${RepositoryPath}/src \
    && mkdir -p ${RepositoryPath}/public \
    && mkdir -p ${RepositoryPath}/public/favicons \
    && mkdir -p ${RepositoryPath}/public/Fonts \
    && mkdir -p ${RepositoryPath}/src/Base \
    && mkdir -p ${RepositoryPath}/src/Components \
    && mkdir -p ${RepositoryPath}/src/Hooks \
    && mkdir -p ${RepositoryPath}/src/Panel \
    && mv /Temp/.env ${RepositoryPath} \
    && mv /Temp/.env.production ${RepositoryPath} \
    && mv /Temp/HeaderActions.jsx ${RepositoryPath}/src \
    && mv /Temp/Logo.jsx ${RepositoryPath}/src \
    && mv /Temp/Menu.jsx ${RepositoryPath}/src \
    && mv /Temp/Routes.jsx ${RepositoryPath}/src \
    && cp -a /Temp/Branding/Favicons/* ${RepositoryPath}/public/favicons \
    && mv /Temp/Branding ${RepositoryPath}/src/Branding \
    && mv /HolismVite/Infra/src/index.css ${RepositoryPath}/src \
    && mv /HolismVite/Infra/src/main.jsx ${RepositoryPath}/src \
    && mv /HolismVite/Infra/src/Fonts ${RepositoryPath}/public \
    && mv /HolismVite/Infra/src/Base ${RepositoryPath}/src \
    && mv /HolismVite/Infra/src/Components ${RepositoryPath}/src \
    && mv /HolismVite/Infra/src/Hooks ${RepositoryPath}/src \
    && mv /HolismVite/Infra/src/Panel ${RepositoryPath}/src \
    && mv /HolismVite/Infra/index.html ${RepositoryPath}/index.html \
    && mv /HolismVite/Infra/vite.config.js ${RepositoryPath} \
    && mv /HolismVite/Infra/tailwind.config.js ${RepositoryPath} \
    && mv /HolismVite/Infra/package.json ${RepositoryPath} \
    && mv /HolismVite/Infra/postcss.config.js ${RepositoryPath} \
    && mv /Temp/* ${RepositoryPath}/src
# RUN find /Temp -maxdepth 1 | sort
# RUN find ${RepositoryPath} | sort
# RUN ls ${RepositoryPath} -lah
WORKDIR ${RepositoryPath}
RUN npm run build

FROM node:lts-alpine as runner
WORKDIR ${RepositoryPath}
ENV NODE_ENV production
RUN npm install --location=global serve
COPY --from=builder ${RepositoryPath}/dist .

EXPOSE 3000
CMD [ "serve", "-s", ".", "-l", "3000" ]
# CMD [ "tail", "-f", "/dev/null" ]