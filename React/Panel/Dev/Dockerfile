FROM node:lts-alpine
WORKDIR /HolismHolding/Infra
RUN apk update \
    && apk add --no-cache git \
    && apk add --upgrade unzip \
    && cd /HolismHolding \
    && git clone https://github.com/HolismReact/Infra \
    && cd /HolismHoldin/Infra \
    && npm install