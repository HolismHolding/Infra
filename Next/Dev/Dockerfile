FROM node:14-buster-slim
RUN apt update
RUN apt install ca-certificates -y
RUN apt install procps -y
RUN apt install curl -y
RUN npx create-next-app -e with-tailwindcss site --use-npm
WORKDIR /site
RUN npm install --no-optional
RUN npm install axios --no-optional
RUN npm install eventemitter3 --no-optional
RUN npm install marked --no-optional
RUN npm install recharts --no-optional
RUN npm install sass --no-optional
RUN npm install @tailwindcss/typography --no-optional
ENV PATH="${PATH}:/HolismHolding/Infra/Next/Dev"
RUN npm install --save-dev eslint eslint-config-next
RUN npm i --save @fortawesome/fontawesome-svg-core \
             @fortawesome/free-solid-svg-icons \
             @fortawesome/free-brands-svg-icons \
             @fortawesome/react-fontawesome --no-optional