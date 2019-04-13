# Specifying the Base Image to build this new image on
FROM node:10.15.3-alpine


# Project's maintainer information
LABEL maintainer="rafmme@gmail.com"

# Set working directory
WORKDIR /src/app/frontend


# Copy source code into the working directory
COPY ./frontend /src/app/frontend


# Install npm dependencies
RUN yarn install


# Bundle project with Webpack
RUN yarn run heroku-postbuild

EXPOSE 3110


# Sets the command and parameters that will be executed first when a container is ran.
ENTRYPOINT [ "yarn", "start" ]
