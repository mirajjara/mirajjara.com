# mirajjara.com

Personal site built with **Jekyll**, **Docker**, and **nginx**.

Intentionally simple. Static. Predictable.
This repository documents the build and deployment pipeline as much as the content itself.

**Architecture:** Mac writes → GitHub stores → CI builds → VPS serves

---

## Project Structure

```
mirajjara.com/
├── site/                      # Content + Jekyll configuration
├── infra/
│   └── nginx/                 # Routing + 404 handling
├── .github/
│   └── workflows/             # CI build & image publish
├── Dockerfile                 # Multi-stage Jekyll build
├── Makefile                   # Local dev shortcuts
└── README.md
```

**Separation of concerns:**
`site/` contains all authoring and Jekyll configuration. Infrastructure and automation are decoupled from content creation.

---

## Environments

| Environment          | Responsibility                          |
| -------------------- | --------------------------------------- |
| **Local (Mac)**      | Writing, local preview, commits         |
| **GitHub**           | Source of truth, CI trigger             |
| **GitHub Actions**   | Build site, package Docker image to GHCR|
| **DigitalOcean VPS** | Serve static site via nginx             |

---

## Current State

- Static site generation with Jekyll
- Containerized builds with Docker
- Automated builds via GitHub Actions → GHCR
- Deployed to a DigitalOcean VPS behind nginx

The system is intentionally boring. Changes should be rare and deliberate.

---

## Local Development

Local development runs entirely in Docker to avoid host dependency drift and accidental cleverness.

Use the `Makefile` for common tasks:

```bash
make bundle    # Install Ruby gems (Dockerized)
make serve     # Run Jekyll dev server at http://localhost:4000
make build     # Build static site into site/_site
make prod      # Build + run production image at http://localhost:8080
make clean     # Remove generated build/cache artifacts
```

**Site is available at:** [http://localhost:4000](http://localhost:4000)

Edits to Markdown files trigger automatic rebuilds.

---

## Open Source + Safety

**Public:**

- Infrastructure code
- Build and deployment automation
- Published posts

**Private (intentionally excluded):**

- Draft posts (`site/_drafts/`)
- Internal planning notes
- Local development artifacts (`vendor/`, caches)

**Security practices:**

- No secrets, credentials, or API keys committed
- Sensitive configuration managed via GitHub Secrets
- Posts focus on high-level lessons and public knowledge only
