# Base Image to build this new image on
FROM node:10.15.3-alpine

# Project's maintainer information
LABEL maintainer="rafmme@gmail.com"

# Set ENV to Production
ENV NODE_ENV=production

# Set working directory
WORKDIR /src/app/backend

# Copy source code into the working directory
COPY ./backend /src/app/backend

# Install npm dependencies
RUN yarn install

# Transpile project down to ES5
RUN yarn run heroku-postbuild

EXPOSE 4000

# Sets the command and parameters that will be executed first when a container is ran.
ENTRYPOINT ["yarn", "start"]
