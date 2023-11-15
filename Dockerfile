ARG RUBY_VERSION=3.2.2

FROM ruby:$RUBY_VERSION-slim

# Install dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev libssl-dev libvips pkg-config

ARG USER_ID=${USER_ID:-1000}
ARG GROUP_ID=${GROUP_ID:-1000}
RUN groupadd --gid ${GROUP_ID} rails \
    && useradd --system --uid ${USER_ID} --gid rails rails \
    && mkdir /bundle \
    && mkdir /rails \
    && chown -R rails:rails /bundle \
    && chown -R rails:rails /rails

# Mount $PWD to this workdir
WORKDIR /rails

# Ensure gems are installed on a persistent volume and available as bins
VOLUME /bundle
RUN bundle config set --global path '/bundle'
ENV PATH="/bundle/ruby/$RUBY_VERSION/bin:${PATH}"

# WORKDIR /rails
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY --chown=rails:rails . .

USER rails
RUN bundle config set path '/bundle'

# Ensure binding is always 0.0.0.0, even in development, to access server from outside container
ENV BINDING="0.0.0.0"

EXPOSE 3000
CMD ["./bin/rails", "server"]
