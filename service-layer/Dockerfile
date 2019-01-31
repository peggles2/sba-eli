FROM ruby:2.5.3
RUN echo "Installing nodejs ..." && \
    apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y curl apt-transport-https && \
    curl -sS https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
    echo 'deb https://deb.nodesource.com/node_7.x jessie main' > /etc/apt/sources.list.d/nodesource.list && \
    apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends nodejs && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# yarn
RUN echo "Installing yarn ..." && \
    apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y curl apt-transport-https && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y yarn && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN apt-get update && \
    apt-get install -y \
        python3 \
        python3-pip \
        python3-setuptools \
        groff \
        less \
        jq \
    && pip3 install --upgrade pip \
    && apt-get clean
RUN pip3 --no-cache-dir install --upgrade awscli
RUN yarn
RUN mkdir /usr/src/api
WORKDIR /usr/src/api
RUN echo "gem: --no-rdoc --no-ri" > /etc/gemrc
ADD Gemfile /usr/src/api/Gemfile
ADD Gemfile.lock /usr/src/api/Gemfile.lock
RUN bundle install --jobs 20 --retry 5
ADD . /usr/src/api
EXPOSE 3000
COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD bash -c "bin/rails db:migrate RAILS_ENV=development && bundle exec rails server -b 0.0.0.0"
