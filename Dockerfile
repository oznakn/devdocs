FROM ruby:2.6.5-alpine

ENV LANG=C.UTF-8
ENV ENABLE_SERVICE_WORKER=true

WORKDIR /devdocs

COPY . /devdocs

RUN apk --update add nodejs build-base libstdc++ gzip git zlib-dev zip unzip curl wget libcurl libffi && \
    gem install bundler && \
    bundle install --system --without test

RUN	thor docs:download \
    bash \
    c \
    cpp \
		cmake@3.10 \
    dart@2 \
    gcc@8 \
    "gcc@8 CPP" \
    gnu_fortran@7 \
    go \
    haskell@8 \
    javascript \
    kotlin \
    "node@8 LTS" \
    "node@10 LTS" \
    openjdk@8 \
    perl@5.26 \
    php \
    python@2.7 \
    python@3.6 \
    python@3.7 \
    ruby@2.5 \
    rust

RUN thor assets:compile && \
    apk del gzip build-base git zlib-dev && \
    rm -rf /var/cache/apk/* /tmp ~/.gem /root/.bundle/cache \
    /usr/local/bundle/cache /usr/lib/node_modules

EXPOSE 9292

CMD rackup -o 0.0.0.0
