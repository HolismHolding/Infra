FROM node:lts-alpine
WORKDIR /HolismReact
RUN apk update \
    && apk add --no-cache git \
    && apk add --upgrade unzip \
    && cd /HolismReact \
    && git clone https://github.com/HolismReact/Infra \
    && cd /HolismReact/Infra \
    && npm install