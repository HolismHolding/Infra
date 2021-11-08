FROM node:14-buster-slim

RUN npx create-next-app -e with-tailwindcss site --use-npm

WORKDIR /site

RUN npm install --no-optional
RUN npm install axios --no-optional
RUN npm install eventemitter3 --no-optional
RUN npm install marked --no-optional
RUN npm install recharts --no-optional
RUN npm install sass --no-optional
RUN npm install @tailwindcss/typography --no-optional
RUN npm install --save-dev eslint eslint-config-next
RUN npm i --save @heroicons/react --no-optional
RUN npm i --save @headlessui/react --no-optional

ENV PATH="${PATH}:/HolismHolding/Infra/Next/Dev"