# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.2.2
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

# Rails app lives here
WORKDIR /app

# Set production environment
ENV RAILS_ENV="dev" \
    BUNDLE_WITHOUT=""

# Install packages needed to build gems and node modules
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential curl git libpq-dev libvips postgresql-client nodejs node-gyp pkg-config python-is-python3

# Install JavaScript dependencies
ARG NODE_VERSION=20.10.0
ARG YARN_VERSION=1.22.22
ENV PATH=/usr/local/node/bin:$PATH
RUN curl -sL https://github.com/nodenv/node-build/archive/master.tar.gz | tar xz -C /tmp/ && \
    /tmp/node-build-master/bin/node-build "${NODE_VERSION}" /usr/local/node && \
    npm install -g yarn@$YARN_VERSION 

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install 

# Copy application code
COPY . .

# Install node modules within Docker container
RUN yarn install --frozen-lockfile

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

# Adjust binfiles to be executable on Linux
RUN chmod 777 bin/* && \
    sed -i "s/\r$//g" bin/* && \
    sed -i 's/ruby\.exe$/ruby/' bin/*

RUN bundle add foreman


# Ensure all bin scripts use /usr/bin/env ruby instead of ruby.exe
RUN sed -i 's/ruby.exe/ruby/' bin/*

RUN chmod +x Procfile.dev

# Precompiling assets for production without requiring secret RAILS_MASTER_KEY
RUN SECRET_KEY_BASE_DUMMY=1 rails assets:precompile

# Install bootstrap
RUN yarn add bootstrap

# Update Browserslist database
RUN npx update-browserslist-db@latest

# Install packages needed for deployment
RUN apt-get update -y && apt-get upgrade -y

# Run and own only the runtime files as a non-root user for security
# RUN useradd rails --create-home --shell /bin/bash && \
#     chown -R rails:rails db log storage tmp
# USER rails:rails

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["./bin/dev", "server"]
