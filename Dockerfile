FROM node:18-alpine3.18

# Install required packages for native modules like sharp and better-sqlite3
RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev nasm bash vips-dev git python3 make g++

ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}

# Set working directory for initial install
WORKDIR /opt/

COPY package.json package-lock.json ./

COPY config/server.js ./config/server.js   #copy the server.js file

RUN npm install -g node-gyp

# Install dependencies
RUN npm config set fetch-retry-maxtimeout 600000 -g && npm install

# Set PATH to include local node_modules
ENV PATH=/opt/node_modules/.bin:$PATH

# Switch to app directory
WORKDIR /opt/app

# Copy source code
COPY . .


# Rebuild native modules like better-sqlite3 inside container
RUN npm rebuild better-sqlite3

# Permissions
RUN chown -R node:node /opt/app

# Use non-root user
USER node

# Build the Strapi admin panel
RUN ["npm", "run", "build"]

EXPOSE 1337

# Start in development mode
CMD ["npm", "run", "develop"]

