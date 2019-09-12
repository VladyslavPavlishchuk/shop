FROM ruby:2.3.8
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /shop
WORKDIR /shop
COPY Gemfile /shop/Gemfile
COPY Gemfile.lock /shop/Gemfile.lock
RUN gem install bundler
RUN bundle install
RUN apt-get install curl
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash
RUN apt-get install nodejs
RUN node -v
RUN npm -v
RUN npm install -g n
RUN n stable
RUN ln -sf /usr/local/n/versions/node/11.8.0/bin/node /usr/bin/node
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn
RUN yarn add jquery
RUN yarn add popper.js
RUN yarn add jquery-ujs
RUN yarn add bootstrap
COPY . /shop

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
