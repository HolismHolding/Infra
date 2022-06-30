FROM node:14-buster-slim

RUN npx create-next-app --example with-tailwindcss site --use-npm

WORKDIR /site

ENV PATH="${PATH}:/HolismHolding/Infra/Next/Dev"

RUN apt update
RUN npm install --location=global npm -y
RUN apt install inotify-tools -y
RUN apt install jq -y

RUN npm i --no-optional
RUN npm i --save axios --no-optional
RUN npm i --save eventemitter3 --no-optional
RUN npm i --save marked --no-optional
RUN npm i --save recharts --no-optional
RUN npm i --save sass --no-optional
RUN npm i --save --save-dev eslint eslint-config-next
RUN npm i --save @heroicons/react --no-optional
RUN npm i --save @headlessui/react --no-optional
RUN npm i --save nodemailer --no-optional
RUN npm i --save cookieconsent --no-optional
RUN npm i --save react-countup --no-optional
RUN npm i --save swiper --no-optional
RUN npm i --save @mui/base --no-optional
RUN npm i --save @mui/material @mui/icons-material @emotion/cache @emotion/react @emotion/server @emotion/styled --no-optional
RUN npm i --save @mui/lab --no-optional
RUN npm i --save @date-io/date-fns --no-optional
RUN npm i --save @date-io/date-fns-jalali --no-optional
RUN npm i --save date-fns --no-optional
RUN npm i --save date-fns-jalali --no-optional
RUN npm i --save react-youtube
# RUN npm i --save wowjs
# Run npm i --save animate.css
RUN npm i --save formik --no-optional
RUN npm i --save yup --no-optional
RUN npm i -D @tailwindcss/typography --no-optional
RUN npm i -D @svgr/webpack
RUN npm i --save stylis stylis-plugin-rtl --no-optional

RUN apt update
RUN apt install curl -y