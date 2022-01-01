FROM node:14-buster-slim
WORKDIR /HolismReact

ENV PATH="${PATH}:/HolismHolding/Infra/React/Dev"  
ENV WDS_SOCKET_PORT=0

RUN apt update \
    && npm install -g npm@8.2.0 -y \
    && apt install inotify-tools -y \
    && apt install git -y \
    && apt install --upgrade unzip -y \
    && cd /HolismReact \
    && git clone https://github.com/HolismReact/Infra \
    && cd /HolismReact/Infra \
    && rm -rf package-lock.json \
    && npm install --legacy-peer-deps

RUN apt update \
    && apt install -y procps \
    && apt install gettext-base