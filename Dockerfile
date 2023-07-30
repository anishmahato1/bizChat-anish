# Use an official Ruby runtime as the base image
FROM ruby:3.1.3

# Set the working directory inside the container
WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  sqlite3 \
  libsqlite3-dev

# Install Rails gem
RUN gem install rails -v '7.0.4'

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install Rails app dependencies
RUN bundle install

# Copy the rest of the Rails app code into the container
COPY . .

# Expose the port that the Rails app will run on
EXPOSE 3000

# Set up the database
RUN rails db:create db:migrate

# Set the default command to run the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
