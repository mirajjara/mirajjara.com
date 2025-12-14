---
layout: page
title: Site stack
permalink: /notes/site-stack/
---

This site is intentionally simple.

### Stack

- **Jekyll**  
  Static site generation. No runtime logic, no database, minimal moving parts.

- **Docker**  
  Multi-stage builds to keep the runtime image small and consistent across environments.

- **GitHub Actions**  
  CI builds the site and container image. No manual deploy steps.

- **nginx**  
  Serves the site on a DigitalOcean VPS.

### Why this setup

I wanted a setup where:
- content lives in Git
- builds are repeatable
- deployment is automated
- the server does as little as possible

Static sites are boring in the best way. There’s nothing to debug at runtime, nothing to scale prematurely, and very little to break.

If this site ever goes down, something has gone seriously wrong.

### Tradeoffs

- No dynamic content
- No comments
- No analytics beyond basic server logs

In this case, it's fine. The goal here is clarity, not engagement.
