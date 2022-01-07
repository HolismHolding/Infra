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
RUN rm -rf ${RepositoryPath}/.git
RUN mkdir -p /Temp
RUN cp -a ${RepositoryPath}/. /Temp
RUN mkdir -p ${RepositoryPath}/src/${Repository}
RUN cp -a /Temp/. ${RepositoryPath}/src/${Repository}
RUN mkdir -p ${RepositoryPath}/src
RUN mkdir -p ${RepositoryPath}/src/Base
RUN mkdir -p ${RepositoryPath}/src/Panel
RUN mkdir -p ${RepositoryPath}/src/Components
RUN mkdir -p ${RepositoryPath}/public
RUN cp ${RepositoryPath}/Logo.js ${RepositoryPath}/src
RUN cp ${RepositoryPath}/Favicon.ico ${RepositoryPath}/public/favicon.ico
RUN cp ${RepositoryPath}/HeaderActions.js ${RepositoryPath}/src
RUN cp ${RepositoryPath}/Menu.js ${RepositoryPath}/src
RUN cp ${RepositoryPath}/Routes.js ${RepositoryPath}/src
RUN cp /HolismReact/Infra/src/index.css ${RepositoryPath}/src
RUN cp /HolismReact/Infra/src/index.js ${RepositoryPath}/src
RUN cp -r /HolismReact/Infra/src/Base ${RepositoryPath}/src
RUN cp -r /HolismReact/Infra/src/Panel ${RepositoryPath}/src
RUN cp -r /HolismReact/Infra/src/Components ${RepositoryPath}/src
RUN cp -a /HolismReact/Infra/public/. ${RepositoryPath}/public
RUN cp /HolismReact/Infra/craco.config.js ${RepositoryPath}
RUN cp /HolismReact/Infra/tailwind.config.js ${RepositoryPath}
RUN cp /HolismReact/Infra/package.json ${RepositoryPath}
RUN cp /HolismReact/Infra/postcss.config.json ${RepositoryPath}
#RUN find ${RepositoryPath}
WORKDIR ${RepositoryPath}
CMD ["npm", "run", "start"]
# RUN npm run build

# FROM node:lts-alpine as runner
# WORKDIR ${RepositoryPath}
# ENV NODE_ENV production
# RUN npm install -g serve
# COPY --from=builder ${RepositoryPath}/build .

# EXPOSE 3000
# CMD [ "serve", "-s", ".", "-l", "3000" ]
# # CMD [ "tail", "-f", "/dev/null" ]