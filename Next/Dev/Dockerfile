FROM node:14-buster-slim

RUN npx create-next-app --example with-tailwindcss site --use-npm

WORKDIR /site

ENV PATH="${PATH}:/HolismHolding/Infra/Next/Dev"

RUN npm i --no-optional
RUN npm i --save axios --no-optional
RUN npm i --save eventemitter3 --no-optional
RUN npm i --save marked --no-optional
RUN npm i --save recharts --no-optional
RUN npm i --save sass --no-optional
RUN npm i --save @tailwindcss/typography --no-optional
RUN npm i --save --save-dev eslint eslint-config-next
RUN npm i --save @heroicons/react --no-optional
RUN npm i --save @headlessui/react --no-optional
RUN npm i --save nodemailer --no-optional
RUN npm i --save cookieconsent --no-optional