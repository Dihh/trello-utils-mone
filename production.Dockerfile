FROM ruby:3.2.2

WORKDIR /app

RUN gem install rails bundler

COPY ./Gemfile /app/Gemfile
COPY ./Gemfile.lock /app/Gemfile.lock

RUN bundle install

RUN chmod +x /app

# CMD ["rails","server","-b","0.0.0.0","-e","production","-C", "--log-to-stdout"]

EXPOSE 3000
