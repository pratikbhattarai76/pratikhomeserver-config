# Cloudflare & Zero Trust Networking

In my server architecture, I selected Cloudflare due to its free Zero Trust tunnels, along with strong security, automatic HTTPS and SSL certificate, global reliability, and the ability to securely expose services without port forwarding or public IP address.

1. 🌍 DNS Management
- Registrar: The Domain "pratik-labs.xyz" was purchased from Namecheap.
- Dns Migration: Nameservers pointed to Cloudflare to leverage the enterprise-grade security and networking suite of Cloudflare.
    Benefit:
        Cloudflare acts as a global shield (Proxy), masking the home network's IP address.
        
2. 🛡️ Cloudflare Tunnels (Zero Trust)
A Cloudflare Tunnel (cloudflared) provides a secure, outbound-only connection from the server to the Cloudflare edge network.

- No Open Ports: Tradidional port forwarding requires "holes" in the firewall, exposing the home network. Whereas, Tunnels require zero open ports.
- Security Posture: All traffic is encrypted between the server and the user.
- Zero Trust Model: "Never Trust, Always Verify". Access is granted based on identity-based rules rather than netwoek location. 

 3. 🆚 Tunneling vs Port Fowwarding
| Feature     | Port Forwarding        | Cloudflare Tunnel             |
| Security    | High risk (Open ports) | Highly secure (No open ports) |
| IP Exposure | Home IP is public      | Home IP is hidden             |
| CGNAT       | Fails behind CGNAT     | Works seamlessly              |
| SSL         | Requires manual setup  | Automated by Cloudflare       |

Note: For CGNAT Users on ISPs like mine, traditional port forwarding is impossible. CLoudflare Tunnels bypass this by indicating the connection from the server outward.
