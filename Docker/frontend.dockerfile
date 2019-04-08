# Specifying the Base Image to build this new image on
FROM node:10.14.1


# Project's maintainer information
LABEL maintainer="rafmme@gmail.com"

# Global install yarn package manager
RUN apt-get update && apt-get install -y curl apt-transport-https && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

# Set working directory
WORKDIR /src/app/frontend


# Copy source code into the working directory
COPY ./frontend /src/app/frontend


# Install npm dependencies
RUN yarn install


# Bundle project with Webpack
RUN yarn run heroku-postbuild


# Sets the command and parameters that will be executed first when a container is ran.
ENTRYPOINT [ "yarn", "start" ]
