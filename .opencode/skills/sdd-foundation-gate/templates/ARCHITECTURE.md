# Architecture

> Project: `<PROJECT_NAME>`
> Type: `Monolith | Microservices`
> Languages/Frameworks: `<list>`

## 1. System Overview
- High-level diagram (ASCII or Mermaid) of components & how they talk

## 2. Folder / Module Structure
```
<root>/
├── src/
│   ├── modules/<module>/    # feature modules
│   ├── services/            # business logic
│   ├── api/                 # routes/handlers/controllers
│   ├── models/              # data models/entities
│   └── utils/               # shared helpers
├── tests/
└── infra/
```

## 3. Request Lifecycle (Data Flow)
1. Client → `<gateway/api>`
2. API layer → auth/validation
3. Service layer → business logic
4. Data layer → DB / external call
5. Response → client (caching? transformation?)

## 4. Components & Communication
| Component | Responsibility | Protocol (REST/gRPC/events) | Consumers |

## 5. Data Layer
- Database(s): type, purpose
- Schema naming convention
- Migrations approach (tool, idempotency, downtime policy)
- Caching strategy

## 6. External Dependencies
- Third-party APIs, message brokers, queues, object storage, caches

## 7. Observability
- Logging, metrics, tracing; key dashboards/alerts

## 8. Deployment
- Target (cloud/on-prem), containers, CI/CD, environments (dev/staging/prod)

## 9. Key Decisions
- ADR log — alternatives considered & why chosen