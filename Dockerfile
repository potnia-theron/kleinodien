ARG RUBY_VERSION=3.2.2

FROM ruby:$RUBY_VERSION-slim

# Install dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev libssl-dev libvips pkg-config

# Mount $PWD to this workdir
WORKDIR /rails

# Ensure gems are installed on a persistent volume and available as bins
VOLUME /bundle
RUN bundle config set --global path '/bundle'
ENV PATH="/bundle/ruby/$RUBY_VERSION/bin:${PATH}"

COPY Gemfile Gemfile.lock ./
RUN bundle install

# Ensure binding is always 0.0.0.0, even in development, to access server from outside container
ENV BINDING="0.0.0.0"

EXPOSE 3000
CMD ["./bin/rails", "server"]
