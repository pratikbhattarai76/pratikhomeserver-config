# Docker
📦 Docker Fundamentals
Docker is a platform for running applications in containers. It follows the philosoply of "Build Once, Run Anywhere."

# Key Concepts
- Docker Image: A read-only blueprint containing the application, its environment, and dependencies.
- Docker Container: A running instance of an image. It is ephemeral (temporary) and isolated from the host OS.
- Registry: A repository (like Docker Hub or GitHub) for storing and sharing images.

1. ⚙️ Container Orchestration
- Isolation: Each service runs in its own sandbox, preventing dependency conflicts between applications.
- Portability: Configurations are defined in docker-compose.yml files, making the entire infrastructure reproducible.

2. ☸️ Portainer Management
- Connectivity: Portainer communicates with the host via the Docker Socket (/var/run/docker.sock).
- Observability: It provides real-time dashboard for monitoring container health, CPU/RAM usage, and system logs.


