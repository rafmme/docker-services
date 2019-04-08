# Base Image to build this new image on
FROM node:10.14.1

# Project's maintainer information
LABEL maintainer="rafmme@gmail.com"

# Set ENV to Production
ENV NODE_ENV=production

# Set working directory
WORKDIR /src/app/backend

# Copy source code into the working directory
COPY ./backend /src/app/backend

# Install npm dependencies
RUN npm install

# Transpile project down to ES5
RUN npm run heroku-postbuild

# Sets the command and parameters that will be executed first when a container is ran.
ENTRYPOINT ["npm", "start"]
