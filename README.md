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
    <tr>
        <td><img width="32" src="https://cdn.jsdelivr.net/gh/walkxcode/dashboard-icons/svg/pgadmin.svg"></td>
        <td><a href="https://www.pgadmin.org/">pgAdmin</a></td>
        <td>Web-based PostgreSQL database management tool with credentials securely fetched from AWS Secrets Manager</td>
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
    <tr>
        <td><img width="32" src="https://camo.githubusercontent.com/5926145ade5befaf2944f207cc20674864519e81d1b2c82123df6a45057fdca8/68747470733a2f2f7777772e7376677265706f2e636f6d2f646f776e6c6f61642f3437373036362f6c6f636b2e737667"></td>
        <td><a href="https://external-secrets.io/">External Secrets Operator</a></td>
        <td>Kubernetes operator that integrates external secret management systems like AWS Secrets Manager</td>
    </tr>
    <tr>
        <td><img width="32" src="https://d2908q01vomqb2.cloudfront.net/22d200f8670dbdb3e253a90eee5098477c95c23d/2020/10/13/1-1.png"></td>
        <td><a href="https://aws.amazon.com/secrets-manager/">AWS Secrets Manager</a></td>
        <td>Centralized cloud-based secrets management service for storing and retrieving application credentials</td>
    </tr>
</table>

## Networking

I use [K3s](https://k3s.io/) with its built-in networking capabilities, which provides a simple yet powerful solution for container networking.

### Storage

My storage strategy revolves around persistent volumes managed by K3s with local paths. For backups, I use CloudNativePG's integration with AWS S3 to ensure data durability.

## Secret Management

I use a multi-layered approach to secret management:

1. **AWS Secrets Manager** - Stores sensitive credentials like database passwords and service access keys
2. **External Secrets Operator** - Pulls secrets from AWS Secrets Manager and creates corresponding Kubernetes secrets
3. **SOPS** - Encrypts sensitive configuration files directly in the Git repository
4. **Flux** - Handles decryption of SOPS-encrypted files during GitOps operations

This approach allows applications like pgAdmin to fetch credentials securely at runtime without storing sensitive data in plain text within Kubernetes manifests or Git repositories.
