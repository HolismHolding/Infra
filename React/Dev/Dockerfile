FROM node:lts-bullseye-slim
WORKDIR /HolismReact

ENV PATH="${PATH}:/HolismHolding/Infra/React/Dev"  

RUN apt update \
    && npm install --location=global npm@8.2.0 -y \
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