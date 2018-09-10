FROM ruby:2.5.1-alpine3.7

RUN apk --update add nodejs netcat-openbsd postgresql-dev
RUN apk --update add --virtual build-dependencies make g++

RUN mkdir /beyondludus

WORKDIR /beyondludus

COPY Gemfile /beyondludus/Gemfile
COPY Gemfile.lock /beyondludus/Gemfile.lock

RUN bundle install
RUN apk del build-dependencies && rm -rf /var/cache/apk/*

COPY . /beyondludus

COPY docker-entrypoint.sh /usr/local/bin

ENTRYPOINT ["docker-entrypoint.sh"]
# CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
