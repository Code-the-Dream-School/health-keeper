# syntax=docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.2.1

# Use the official Ruby image with version 3.2.0
FROM ruby:$RUBY_VERSION

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  nodejs \
  postgresql-client \
  libssl-dev \
  libreadline-dev \
  zlib1g-dev \
  build-essential \
  curl

# Set the working directory
WORKDIR /app

# Copy Gemfile and create Gemfile.lock if it doesn't exist
COPY Gemfile Gemfile.lock* ./

# Install gems with full index
RUN bundle config set --local path 'vendor/bundle' && \
    bundle config set --local without 'development test' && \
    bundle install --full-index --jobs 4 --retry 3

# Copy the application code
COPY . /app

# Precompile assets
RUN bundle exec rake assets:precompile

# Expose the port the app runs on
EXPOSE 3000

# Remove server.pid on container start and run the server
ENTRYPOINT rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'
