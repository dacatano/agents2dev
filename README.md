# Agent Foundry

Container-based multi-agent laboratory designed for controlled orchestration,
host-managed execution, and future Kubernetes evolution.

## Overview

Agent Foundry is a modular environment for running multiple AI agents
inside isolated containers while maintaining:

- A shared project workspace
- A host-side control-plane
- Network isolation between agents
- Resource limits (CPU / memory)
- Clean reproducibility with Podman Compose
- Kubernetes-ready architecture

The system separates responsibilities:

- Agents generate requests
- Goose coordinates via control-plane
- Host listener executes ephemeral test containers
- Runtime privileges remain outside agent containers

This avoids Docker-in-Docker and keeps the control-plane secure.

---

## Architecture
Agents (containers)
↓
File-based control-plane (/control-plane)
↓
Host listener
↓
Ephemeral test containers


### Networks

- `internal-net` → isolated agent communication
- `internet-net` → optional outbound access for selected agents

---

## Project Structure
agent-foundry/
│
├── agents/
│ ├── goose/
│ ├── gemini/
│ ├── kimi/
│ └── opencode/
│
├── project/ # shared workspace
├── control-plane/ # event queue
├── scripts/ # host automation
├── podman-compose.yml
├── Makefile
└── README.md

---

## Quick Start

### Build and start environment

```bash
make up
```

### Run host control-plane listener

make listener

### Trigger test requests

make test-request

### Stop environment

make down
