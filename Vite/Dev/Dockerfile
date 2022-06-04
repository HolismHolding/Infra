FROM node:lts-bullseye-slim
WORKDIR /HolismVite

ENV PATH="${PATH}:/HolismHolding/Infra/Vite/Dev"  

RUN apt update \
    && npm install -g npm@8.2.0 -y \
    && apt install inotify-tools -y \
    && apt install git -y \
    && apt install --upgrade unzip -y \
    && cd /HolismVite \
    && git clone https://github.com/HolismVite/Infra \
    && cd /HolismVite/InfraVite \
    && rm -rf package-lock.json \
    && npm install --legacy-peer-deps

RUN apt update \
    && apt install -y procps \
    && apt install gettext-base