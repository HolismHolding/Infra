FROM node:lts-bullseye-slim
WORKDIR /HolismVite

ENV PATH="${PATH}:/HolismHolding/Infra/Vite/Dev"  

RUN apt update
RUN npm install -g npm@8.2.0 -y
RUN apt install inotify-tools -y
RUN apt install git -y
RUN apt install --upgrade unzip -y
RUN cd /HolismVite
RUN git clone https://github.com/HolismVite/Infra
RUN cd /HolismVite/Infra
RUN rm -rf package-lock.json
RUN npm install --legacy-peer-deps

RUN apt update
RUN apt install -y procps
RUN apt install gettext-base