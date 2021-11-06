FROM holism/next-dev:latest as dependencies
WORKDIR ${RepositoryPath}
# COPY /HolismNext/Infra/package.json /HolismNext/Infra/package-lock.json ./
# RUN npm install

FROM node:14-buster-slim as builder
COPY /HolismHolding/Infra /HolismHolding/Infra
COPY /HolismNext/Infra /HolismNext/Infra
COPY ${RepositoryPath} ${RepositoryPath}
COPY --from=dependencies /site/node_modules ${RepositoryPath}/node_modules
COPY --from=dependencies /site/package.json ${RepositoryPath}/package.json
RUN cp -a /HolismNext/Infra/. ${RepositoryPath}
WORKDIR ${RepositoryPath}
RUN npm run build

FROM node:14-buster-slim as runner
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