# mirajjara.com

Production-grade personal site and blog built with **Jekyll** and **Docker**, designed to practice real-world infrastructure, automation, and deployment workflows. This repository is an **engineering artifact** demonstrating containerized development, separation of concerns, and CI/CD principles, not just a content project.

**Architecture:** Mac writes -> GitHub stores -> CI builds -> VPS serves

---

## Project Structure

```
miraj-site/
├── site/                      # APPLICATION (Authoring)
│   ├── _posts/                # Markdown content
│   ├── _drafts/               # gitignored
│   ├── _config.yml
│   └── Gemfile
│
├── infra/                     # CONFIGURATION (Internal)
│   └── nginx/
│       └── default.conf       # 404 handling & routing
│
├── ops/                       # ORCHESTRATION (Deployment)
│   ├── compose.prod.yml       # VPS Docker definition
│   ├── Caddyfile              # Reverse proxy + TLS
│   └── README.md              # Server runbook
│
├── .github/                   # AUTOMATION
│   └── workflows/             # CI/CD pipelines
│
├── Dockerfile                 # Multi-stage build definition
└── README.md                  # This architecture document
```

**Separation of concerns:**
`site/` contains all authoring and Jekyll configuration. Future phases introduce infrastructure and automation without coupling them to content creation.

---

## Environments

| Environment | Responsibility |
|-------------|----------------|
| **Mac (local)** | Content authoring, local preview via Docker, Git commits |
| **GitHub** | Version control, source of truth, CI triggers |
| **CI (GitHub Actions)** | Build static site, package Docker image, push to GHCR |
| **VPS** | Production runtime; pulls images and serves traffic via reverse proxy |

---

## Roadmap / Phases

- **Phase 0:**  Repository setup, architecture definition, git hygiene (complete)
- **Phase 1:**  Dockerized local authoring (Bundler + Jekyll serve with hot reload) (complete)
- **Phase 2:** CI/CD pipeline (GitHub Actions -> build -> push to GHCR)
- **Phase 3:** VPS deployment (Docker Compose, image pulls, runtime orchestration)
- **Phase 4:** Production hardening (reverse proxy, TLS, monitoring, backups)

---

## Local Development

All local development runs entirely in Docker to ensure consistency and avoid host dependency drift.

**Install dependencies:**

```bash
docker run --rm -it \
  -v "$(pwd)/site":/srv/jekyll \
  -w /srv/jekyll \
  -e BUNDLE_PATH=/srv/jekyll/vendor/bundle \
  jekyll/jekyll:4.2.2 \
  bundle install
```

**Run local server:**

```bash
docker run --rm -it \
  -p 4000:4000 \
  -v "$(pwd)/site":/srv/jekyll \
  -w /srv/jekyll \
  -e BUNDLE_PATH=/srv/jekyll/vendor/bundle \
  jekyll/jekyll:4.2.2 \
  bundle exec jekyll serve --watch --force_polling --host 0.0.0.0
```

Site is available at: **http://localhost:4000**

Edits to Markdown files trigger automatic rebuilds.

---

## Open Source + Safety

**Public:**

- Infrastructure code
- Build and deployment automation
- Published posts

**Private (intentionally excluded):**

- Draft posts (`site/_drafts/`)
- Internal planning notes (`DEV_NOTES.md`)
- Local development artifacts (`vendor/`, caches)

**Security practices:**

- No secrets, credentials, or API keys committed 
- Sensitive configuration managed via GitHub Secrets and environment variables
- Work-related posts focus on high-level lessons and public knowledge only

**This repository prioritizes reproducibility, clarity, and long-term maintainability over rapid iteration.**