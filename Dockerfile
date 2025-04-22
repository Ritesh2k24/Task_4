FROM node:18

WORKDIR /app

COPY package*.json ./

RUN npm install --production

COPY . .

EXPOSE 1337

RUN npm run build

CMD ["npm", "run", "start"]
