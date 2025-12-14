SHELL := /bin/bash

JEKYLL_IMAGE := jekyll/jekyll:4.2.2
SITE_DIR := $(CURDIR)/site
BUNDLE_PATH := /srv/jekyll/vendor/bundle
IMAGE_NAME := mirajjara-site:local

.PHONY: help bundle serve build prod clean

help:
	@echo ""
	@echo "Targets:"
	@echo "  make bundle   Install Ruby gems (Dockerized)"
	@echo "  make serve    Run Jekyll dev server at http://localhost:4000"
	@echo "  make build    Build static site into site/_site"
	@echo "  make prod     Build + run production image at http://localhost:8080"
	@echo "  make clean    Remove generated build/cache artifacts"
	@echo ""

bundle:
	docker run --rm -it \
	  -v "$(SITE_DIR)":/srv/jekyll \
	  -w /srv/jekyll \
	  -e BUNDLE_PATH=$(BUNDLE_PATH) \
	  $(JEKYLL_IMAGE) \
	  bundle install

serve:
	docker run --rm -it \
	  -p 4000:4000 \
	  -v "$(SITE_DIR)":/srv/jekyll \
	  -w /srv/jekyll \
	  -e BUNDLE_PATH=$(BUNDLE_PATH) \
	  $(JEKYLL_IMAGE) \
	  bundle exec jekyll serve --watch --force_polling --host 0.0.0.0

build:
	docker run --rm -it \
	  -v "$(SITE_DIR)":/srv/jekyll \
	  -w /srv/jekyll \
	  -e BUNDLE_PATH=$(BUNDLE_PATH) \
	  $(JEKYLL_IMAGE) \
	  bundle exec jekyll build

prod:
	docker build -t $(IMAGE_NAME) .
	docker run --rm -p 8080:80 $(IMAGE_NAME)

clean:
	rm -rf site/_site site/.jekyll-cache site/.sass-cache site/.jekyll-metadata
