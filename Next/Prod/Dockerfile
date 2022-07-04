FROM holism/next-dev:latest as dependencies
WORKDIR ${RepositoryPath}

FROM node:lts-bullseye-slim as builder
COPY /HolismHolding/Infra /HolismHolding/Infra
COPY /HolismNext/Infra /HolismNext/Infra
COPY ${RepositoryPath} ${RepositoryPath}
COPY /${Organization}/Common /${Organization}/Common
COPY --from=dependencies /site/node_modules ${RepositoryPath}/node_modules
COPY --from=dependencies /site/package.json ${RepositoryPath}/package.json
COPY --from=dependencies /site/postcss.config.js ${RepositoryPath}/postcss.config.js
RUN cp -a /HolismNext/Infra/. ${RepositoryPath}
RUN if [ ! -d "${RepositoryPath}/contents" ]; then mkdir ${RepositoryPath}/contents; fi
RUN echo dummy > ${RepositoryPath}/contents/dummy.md
RUN if [ ! -d "${RepositoryPath}/public" ]; then mkdir ${RepositoryPath}/public; fi
RUN echo dummy > ${RepositoryPath}/public/dummy.md
WORKDIR ${RepositoryPath}
RUN ls -lah
RUN npm run build --debug

FROM node:lts-bullseye-slim as runner
WORKDIR ${RepositoryPath}
ENV NODE_ENV production
COPY --from=builder ${RepositoryPath}/next.config.js ./
COPY --from=builder ${RepositoryPath}/public ./public
COPY --from=builder ${RepositoryPath}/.next ./.next
COPY --from=builder ${RepositoryPath}/contents ./contents
COPY --from=builder ${RepositoryPath}/node_modules ./node_modules
COPY --from=builder ${RepositoryPath}/package.json ./package.json

EXPOSE 3000
CMD ["npm", "start"]