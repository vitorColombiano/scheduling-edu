FROM ruby:4.0

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs

WORKDIR /app

RUN gem install rails

CMD ["bash"]
