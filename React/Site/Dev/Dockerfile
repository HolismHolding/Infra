FROM node:lts-alpine
RUN npx create-next-app site --use-npm
WORKDIR /site
RUN npm install
RUN npm install node-sass@4.14.1
ENV PATH="${PATH}:/HolismHolding/Infra/React/Site/Dev"
RUN npm install marked
RUN npm install