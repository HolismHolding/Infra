FROM node:lts-alpine
RUN npx create-next-app -e with-tailwindcss site --use-npm
WORKDIR /site
RUN npm install
RUN npm install marked
RUN npm install node-sass@4.14.1
RUN npm install @tailwindcss/typography
ENV PATH="${PATH}:/HolismHolding/Infra/Next/Dev"
RUN npm install --save-dev eslint eslint-config-next
RUN npm i --save @fortawesome/fontawesome-svg-core \
             @fortawesome/free-solid-svg-icons \
             @fortawesome/free-brands-svg-icons \
             @fortawesome/react-fontawesome