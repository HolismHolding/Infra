FROM node:lts-alpine
WORKDIR /HolismReact

ENV PATH="${PATH}:/HolismHolding/Infra/React/Dev"  

RUN apk update \
    && npm install -g npm@8.2.0 \
    && apk add --no-cache inotify-tools \
    && apk add --no-cache git \
    && apk add --upgrade unzip \
    && cd /HolismReact \
    && git clone https://github.com/HolismReact/Infra \
    && cd /HolismReact/Infra \
    && rm -rf package-lock.json \
    && npm install --legacy-peer-deps