FROM ruby:4.0.1

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs

WORKDIR /app

# Install Rails (optional, since it's usually in your Gemfile)
RUN gem install rails

# Add Gemfiles and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the rest of the app
COPY . .

CMD ["rails", "server", "-b", "0.0.0.0"]