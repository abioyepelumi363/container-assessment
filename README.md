# MuchTodo Container Assessment

This repository contains the containerization and orchestration setup for the MuchTodo backend application using Docker and Kubernetes (Kind).

## Project Structure
.
├── Dockerfile              # Multi-stage build configuration
├── docker-compose.yml      # Local development setup with MongoDB
├── kubernetes/             # Kubernetes manifests
│   ├── backend/            # Backend deployment, service, secrets
│   ├── mongodb/            # MongoDB deployment, PVC, secrets
│   └── ingress.yaml        # Ingress configuration
├── scripts/                # Automation scripts
└── README.md               # Documentation

## Prerequisites
- Docker & Docker Compose
- Kind (Kubernetes in Docker)
- Kubectl
- Go 1.25+

## Phase 1: Local Development (Docker)
To run the application locally using Docker Compose:

1. **Build the image:**
   ```bash
   ./scripts/docker-build.sh