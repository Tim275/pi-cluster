# 🏠 Homelab

## Introduction

This repo contains all of the configuration and documentation of my homelab.

The purpose of my homelab is to learn and to have fun. Being a Cloud Native Engineer by trade, I work with Kubernetes every day, and my homelab is the place where I can try out and learn new things. On the other hand, by self-hosting some applications, it makes me feel responsible for the entire process of deploying and maintaining an application from A to Z. It forces me to think about backup strategies, security, scalability and the ease of deployment and maintenance.

## Cluster Provisioning & Architecture

I use [K3s](https://k3s.io/) to set up my cluster. I prefer K3s because it is lightweight and minimal, optimized for edge and IoT environments while still providing production-grade capabilities.

## :computer: Hardware

### Nodes

I use Raspberry Pi computers for my cluster, which offer great performance in a small form factor with minimal power consumption.

- Raspberry Pi 4 Model B 8GB RAM (Master Node)
- Raspberry Pi 4 Model B 8GB RAM (Worker Node)

## :rocket: Installed Apps & Tools

### Apps

End User Applications

<table>
    <tr>
        <th>Logo</th>
        <th>Name</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><img width="32" src="https://cdn.jsdelivr.net/gh/walkxcode/dashboard-icons/svg/linkding.svg"></td>
        <td><a href="https://github.com/sissbruecker/linkding">Linkding</a></td>
        <td>Self-hosted bookmark manager with browser extensions</td>
    </tr>
    <tr>
        <td><img width="32" src="https://cdn.jsdelivr.net/gh/walkxcode/dashboard-icons/svg/audiobookshelf.svg"></td>
        <td><a href="https://www.audiobookshelf.org/">Audiobookshelf</a></td>
        <td>Self-hosted audiobook and podcast server</td>
    </tr>
</table>

### Infrastructure

Everything needed to run my cluster & deploy my applications

<table>
    <tr>
        <th>Logo</th>
        <th>Name</th>
        <th>Description</th>
    </tr>
   <tr>
        <td><img width="32" src="https://cdn.jsdelivr.net/gh/cilium/cilium/Documentation/images/logo-solo.svg"></td>
        <td><a href="https://cilium.io/">Cilium</a></td>
        <td>eBPF-based networking, observability and security for Kubernetes</td>
    </tr>
    <tr>
        <td><img width="32" src="https://cdn.jsdelivr.net/gh/walkxcode/dashboard-icons/png/cloudflare-zero-trust.png"></td>
        <td><a href="https://developers.cloudflare.com/cloudflare-one/">Cloudflare Zero Trust</a></td>
        <td>Used for private tunnels to expose public services (without requiring a public IP).</td>
    </tr>
    <tr>
        <td><img width="32" src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/postgresql.svg"></td>
        <td><a href="https://cloudnative-pg.io/">CloudNativePG</a></td>
        <td>Database operator for running PostgreSQL clusters with AWS S3 backups</td>
    </tr>
    <tr>
        <td><img width="32" src="https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/flux-cd.svg"></td>
        <td><a href="https://fluxcd.io/">Flux CD</a></td>
        <td>My GitOps solution of choice for managing cluster resources</td>
    </tr>
    <tr>
        <td><img width="32" src="https://cdn.jsdelivr.net/gh/walkxcode/dashboard-icons/svg/grafana.svg"></td>
        <td><a href="https://grafana.com/">Grafana</a></td>
        <td>The open observability platform</td>
    </tr>
    <tr>
        <td><img width="32" src="https://cdn.jsdelivr.net/gh/walkxcode/dashboard-icons/svg/prometheus.svg"></td>
        <td><a href="https://prometheus.io/">Prometheus</a></td>
        <td>An open-source monitoring system with a dimensional data model, flexible query language, efficient time series database and modern alerting approach</td>
    </tr>
    <tr>
        <td><img width="32" src="https://www.svgrepo.com/download/374041/renovate.svg"></td>
        <td><a href="https://github.com/renovatebot/renovate">Renovate</a></td>
        <td>Automated dependency updates</td>
    </tr>
    <tr>
    <td><img width="32" src="https://cdn.prod.website-files.com/5eb586cf8a64e8125e18ebe7/62fced424b98d03e45ff79ed_AWS%20S3-sq.png"></td>
    <td><a href="https://aws.amazon.com/s3/">AWS S3</a></td>
    <td>Cloud object storage for database backups and disaster recovery</td>
</tr>
</table>
## Networking

I use [K3s](https://k3s.io/) with its built-in networking capabilities, which provides a simple yet powerful solution for container networking.

### Storage

My storage strategy revolves around persistent volumes managed by K3s with local paths. For backups, I use CloudNativePG's integration with AWS S3 to ensure data durability.

## Secret Management

AWS S3 and SOPS are used to securely store my secrets. I use flux to decrypt and apply these secrets to my cluster, ensuring sensitive information remains protected.

Similar code found with 1 license type
