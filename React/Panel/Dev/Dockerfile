FROM node:lts-alpine
RUN apk update \
    && apk add --no-cache git \
    && apk add --upgrade unzip \
    && mkdir /HolismHolding \
    && chmod 777 /HolismHolding \
    && cd /HolismHolding \
    && git clone https://github.com/HolismReact/Infra \
    && cd /HolismHoldin/Infra \
    && npm install