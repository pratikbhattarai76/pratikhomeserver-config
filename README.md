# 🛡️ Pratik-Labs: Automated Hybrid-Cloud Infrastructure
A professional-grade, high-availability home laboratory designed for **Infrastructure-as-Code (IaC)**, **Zero Trust Networking**, and **Hardware-Accelerated Media Services**.

---

## 🎯 Project Overview
Pratik-Labs is a production-ready server environment built on **Ubuntu 24.04 LTS**. It utilizes a "Thin-Host" philosophy where the base Operating System remains minimal, and all application logic is orchestrated via **Docker Compose** and **Ansible**.

The infrastructure is managed from a dedicated **Arch Linux** workstation, establishing a professional development-to-production pipeline.

## 🖥️ Hardware Specifications
| Component | Specification |
| :--- | :--- |
| **CPU** | Intel® Core™ i7-4770 (4C/8T) |
| **GPU** | NVIDIA GeForce GTX 1660 Super (Turing NVENC) |
| **RAM** | 16GB DDR3 1333MHz |
| **OS Drive** | 128GB SSD (High-Performance Metadata Tier) |
| **Data Drive** | 1TB HDD (Mass Storage Capacity Tier) |
| **Network** | Static IP Implementation (`192.168.1.250`) |

## 🏗️ Architecture & Security Posture
- **Infrastructure as Code:** System initialization and configuration management are handled via **Ansible Playbooks**, ensuring an "idempotent" and reproducible environment.
- **Zero Trust Networking:** Utilizes **Cloudflare Tunnels (`cloudflared`)** to provide secure, outbound-only connectivity. This eliminates the need for inbound port forwarding and masks the home IP address.
- **Centralized Ingress:** **Nginx Proxy Manager** serves as a Layer-7 Reverse Proxy, handling internal service discovery via Docker DNS and providing SSL termination.
- **Data Persistence:** Implements a tiered storage model using **Named Volumes** for application state and **UUID-based mounting** for hardware-level durability.
- **GPU Passthrough:** Integrated **NVIDIA Container Toolkit** to allow Dockerized applications access to the 1660 Super for low-latency video transcoding.
- **Administrative VPN** Utilizes **Tailscale (WireGuard-based Mesh VPN)** for sevure, encrypted SSH access. This provides a private management plane that is independent of the public Cloudflare route, ensuring "Backdoor" access for maintenance.

## 📂 Repository Structure
```text
.
├── ansible
│   ├── hosts.ini
│   └── setup.yml
├── cloudflared
│   └── config.yml
├── docker
│   └── services
│       ├── docker-compose.yml
│       └── env.example
├── docs
│   ├── cloudflare-networking.md
│   ├── docker-containerization.md
│   └── ubuntu-setup.md
├── LICENSE
├── README.md
└── scripts
    └── setup.sh
```




