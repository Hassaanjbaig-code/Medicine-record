# syntax = docker/dockerfile:1

# Use Ruby version as an argument
ARG RUBY_VERSION=3.2.2
FROM ruby:$RUBY_VERSION-slim as base

# Set the working directory inside the container
WORKDIR /app

# Set environment variables for the Rails application
ENV RAILS_ENV="development" \
    BUNDLE_WITHOUT=""

# Install required system dependencies
RUN apt-get update -qq && apt-get install --no-install-recommends -y \
    build-essential \
    curl \
    git \
    libpq-dev \
    libvips \
    postgresql-client \
    nodejs \
    node-gyp \
    pkg-config \
    python-is-python3 \
    redis \
 && rm -rf /var/lib/apt/lists/*

# Install Node.js and Yarn
ARG NODE_VERSION=20.10.0
ARG YARN_VERSION=1.22.22
ENV PATH=/usr/local/node/bin:$PATH
RUN curl -sL https://github.com/nodenv/node-build/archive/master.tar.gz | tar xz -C /tmp/ && \
    /tmp/node-build-master/bin/node-build "${NODE_VERSION}" /usr/local/node && \
    npm install -g yarn@$YARN_VERSION

# Install gems required by the application
COPY Gemfile Gemfile.lock ./ 
RUN bundle install

# Copy the application code into the container
COPY . .

# Ensure docker-entrypoint is executable
# RUN chmod +x ./bin/docker-entrypoint

# Install Node.js modules
# RUN yarn install --frozen-lockfile

# Precompile bootsnap to improve startup performance
RUN bundle exec bootsnap precompile app/ lib/

# Ensure bin files are Linux-compatible
RUN find bin -type f -exec sed -i 's/\r$//g' {} + && \
    find bin -type f -exec sed -i 's/ruby\.exe/ruby/' {} + && \
    chmod +x bin/*

# Add Foreman for process management
RUN bundle add foreman

# Ensure Procfile.dev is executable
RUN chmod +x Procfile.dev

# Precompile assets if required for production (commented for development)
# RUN rails assets:precompile

# Install Bootstrap (optional, specific to the application)
RUN yarn add bootstrap

# Update Browserslist database
RUN npx update-browserslist-db@latest

RUN yarn remove esbuild

RUN ./bin/rails javascript:install:esbuild

# RUN rails db:migrate

RUN chmod +x ./bin/docker-entrypoint.sh

# ENTRYPOINT ["/bin/bash", "./bin/docker-entrypoint"]
ENTRYPOINT ["sh", "./bin/docker-entrypoint.sh"]

# Expose port 3000 for the Rails server
EXPOSE 3000

# Set the default command to run the Rails development server
CMD ["foreman", "start", "-f", "Procfile.dev"]
