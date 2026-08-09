# Hotel Reservations BI Application

A business intelligence application for analyzing hotel reservation data, built with Django and Next.js.

# Tech Stack

- **Backend**: Django 5 / Python 3.10 / Django REST Framework
- **Frontend:** React / Next.js 14 (App Router) / Tailwind CSS
- **Database:** SQLite
- **Data Analysis:** Jupyter with Django kernel
- **Containerization:** Docker Compose

## Getting Started

### Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/)

### Build

```bash
docker compose build
```

### Run

```bash
docker compose up -d --wait
```

The `--wait` flag tells Docker to block until all services are healthy (frontend `npm install` can take ~1-2 min on first run).

### Verify

```bash
bash verify.sh
```

### Services

| Service  | URL                   |
|----------|-----------------------|
| Frontend | http://localhost:9010 |
| Backend  | http://localhost:9011 |
| Jupyter  | http://localhost:9012 |

### Development

Open a shell in the containers:

```bash
docker exec -it interview-assignment-2-backend bash
docker exec -it interview-assignment-2-frontend bash
```

> **Note:** Do not run `makemigrations` — migrations are pre-generated and frozen.

This is a minimal scaffold. The full application and data will be delivered at the start of the interview.
