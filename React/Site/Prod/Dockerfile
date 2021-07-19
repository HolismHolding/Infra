FROM holism/next-dev:latest as dependencies
WORKDIR ${RepositoryPath}
COPY /HolismReact/Site/package.json /HolismReact/Site/package-lock.json ./
# RUN npm install

FROM node:lts-alpine as builder
WORKDIR ${RepositoryPath}
COPY /HolismHolding/Infra /HolismHolding/Infra
COPY /HolismReact/Site /HolismReact/Site
COPY ${RepositoryPath} ${RepositoryPath}
COPY --from=dependencies ${RepositoryPath}/node_modules ./node_modules
RUN npm run build

FROM node:lts-alpine as runner
WORKDIR ${RepositoryPath}
ENV NODE_ENV production
# COPY --from=builder /my-project/next.config.js ./
COPY --from=builder ${RepositoryPath}/public ./public
COPY --from=builder ${RepositoryPath}/.next ./.next
COPY --from=builder ${RepositoryPath}/node_modules ./node_modules
COPY --from=builder ${RepositoryPath}/package.json ./package.json

EXPOSE 3000
CMD ["npm", "start"]