# ---- Build stage: Rendering the Jekyll pages ----
FROM ruby:3.2-alpine AS build
WORKDIR /app

RUN apk add --no-cache build-base git

ENV BUNDLE_PATH=/usr/local/bundle

COPY site/Gemfile site/Gemfile.lock ./
RUN gem install bundler && bundle install

COPY site/ .

RUN bundle exec jekyll build

# ---- Runtime stage: Nginx to serve the already rendered pages ----
FROM nginx:alpine
COPY infra/nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/_site /usr/share/nginx/html
