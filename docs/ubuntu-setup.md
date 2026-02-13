# Ubuntu Server Environment

🎯 Architecture Overview
The Operating System for the server is selected to be Ubuntu 24.04.4 LTS due to its long-term stability, extensive hardware compatibility, strong Docker and NVIDIA ecosystem support, large community, and reliable five year security maintenance, which makes it ideal for low-maintenance production home server environment.
The system is also designed as Hybrid-Storage Server where the Operating System is proritized for speed, and bulk data is prioritized for capacity and persistence.

1. Storage Strategy
- Host OS: The OS is installed on a 128GB SSD. This ensures that the Docker engine, metadata, and system logs load with minimal latency.
- Bulk Storage: A 1TB HDD is mounted at /mnt/storage for bulk data storage.
- Persitence (UUID): I utilized the UUID (Universally Unique Identifier) in /etc/fstab to ensure the mount point for the HDD is immutable.
    Why?
        Unlike /dev/sda1, which can change if the hardware is reordered, a 128-bit UUID is tied to the partition's metadata. This prevents the server from failing to boot if new drivers are added.

2. Networking and Stability
- Static IP Configuration: DHCP is disabled in favor of a manual assignment of the IP. 192.168.1.250 ip is selected to be the Static IP.
    Logic:
        Home routers often rotate IP addresses. By pinning the server to .250, I ensured that my SSH links and Cloudflare Tunnels never lose their target.

3. Hardware-Accelerated Logic
- NVIDIA 1660 Super: Integrated using the NVIDIA Container Toolkit.
    Purpose:
        This enables "Pass-through" capabilites, allowing isolated Docker containers to access the GPU's NVENC Turing encoder for high-efficienct video transcoding along with high quality, low-latency and, minimal CPU overhead.
