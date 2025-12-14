# ---- Build stage: render the Jekyll site ----
FROM ruby:3.2-alpine AS build
WORKDIR /app

RUN apk add --no-cache \
  build-base \
  git \
  tzdata \
  libc6-compat

ENV BUNDLE_PATH=/usr/local/bundle
ENV JEKYLL_ENV=production

COPY site/Gemfile site/Gemfile.lock ./
RUN gem install bundler && bundle install

COPY site/ .

RUN bundle exec jekyll build --trace

# ---- Runtime stage: nginx serves the static output ----
FROM nginx:alpine

COPY infra/nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/_site /usr/share/nginx/html
