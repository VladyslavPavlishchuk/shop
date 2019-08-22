FROM ruby:2.3.8
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /shop
WORKDIR /shop
COPY Gemfile /shop/Gemfile
COPY Gemfile.lock /shop/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /shop

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
