
1. Hardware-Grundlagen
Optimale Hardware-Auswahl
Raspberry Pi 5 mit 8GB RAM (wie in deinem Setup)
Aktive Kühlung für stabile CPU-Frequenz
USB 3.0 SSDs statt SD-Karten für bessere I/O-Performance




Umfassende Best Practices: Hardware- und Systemkonfiguration für K3s auf Raspberry Pi
Basierend auf unseren früheren Gesprächen und deinen aktuellen Ergebnissen (2% CPU, ~45% RAM-Nutzung) hier eine vollständige Zusammenfassung der Best Practices, die zu diesem hervorragenden Ergebnis geführt haben:

1. Hardware-Grundlagen
Optimale Hardware-Auswahl
Raspberry Pi 5 mit 8GB RAM (wie in deinem Setup)
Aktive Kühlung für stabile CPU-Frequenz
USB 3.0 SSDs statt SD-Karten für bessere I/O-Performance
Hardware-Zuweisung
Gleichmäßige Verteilung zwischen Master und Worker (wie deine Metriken zeigen)
Node Labels für spezifische Workload-Platzierung




2. Speicherkonfiguration
# SSD formatieren und einbinden
sudo mkfs.ext4 -L k3sdata /dev/sda1
sudo mkdir -p /var/lib/rancher
sudo mount -o defaults,noatime /dev/sda1 /var/lib/rancher

# Automount konfigurieren
echo "LABEL=k3sdata /var/lib/rancher ext4 defaults,noatime 0 0" | sudo tee -a /etc/fstab

# Swap-Verhalten für Kubernetes optimieren
echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.d/99-kubernetes.conf
sudo sysctl -w vm.swappiness=10


3. Kernel-Parameter für optimale Performance
# CGroup-Unterstützung im Kernel aktivieren - KRITISCH für K3s
sudo sed -i '$ s/$/ cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory/' /boot/firmware/cmdline.txt
sudo reboot
#Netzwerk-Parameter für Kubernetes
cat << EOF | sudo tee /etc/sysctl.d/99-kubernetes.conf
net.ipv4.ip_forward=1
net.bridge.bridge-nf-call-iptables=1
net.bridge.bridge-nf-call-ip6tables=1
vm.swappiness=10
vm.overcommit_memory=1
vm.panic_on_oom=0
kernel.panic=10
kernel.panic_on_oops=1
fs.inotify.max_user_instances=8192
fs.inotify.max_user_watches=524288
EOF

sudo sysctl --system

#eBPF-Optimierung für Cilium
cat << EOF | sudo tee /etc/sysctl.d/99-cilium-bpf.conf
kernel.pid_max=65535
net.core.bpf_jit_limit=3000000000
fs.inotify.max_user_watches=524288
fs.inotify.max_user_instances=8192
EOF

sudo sysctl --system


4. Grafik-Ressourcen minimieren
# GPU-Speicher reduzieren (wir brauchen keinen für Headless-Server)
sudo nano /boot/firmware/config.txt

# Füge hinzu:
gpu_mem=16

 5. K3s-Installation mit optimierten Parametern

curl -sfL https://get.k3s.io | sh -s - server \

# Worker-Node
# NODE_TOKEN von Master-Node abrufen
NODE_TOKEN=$(sudo cat /var/lib/rancher/k3s/server/node-token)
MASTER_IP=$(hostname -I | awk '{print $1}')

# Worker-Node joinen
curl -sfL https://get.k3s.io | K3S_URL=https://${MASTER_IP}:6443 K3S_TOKEN=${NODE_TOKEN} sh -


6. Cilium CNI für optimale Netzwerk-Performance

# Helm installieren
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Cilium 1.14.5 mit optimierten Einstellungen für Raspberry Pi
helm repo add cilium https://helm.cilium.io/
helm repo update
helm install cilium cilium/cilium --version 1.14.5 \
  --namespace kube-system \
  --set kubeProxyReplacement=strict \
  --set operator.replicas=1 \
  --set hubble.enabled=true \
  --set hubble.relay.enabled=true \
  --set hubble.ui.enabled=true \
  --set clustermesh.apiserver.enabled=true \
  --set resources.limits.cpu=200m \
  --set resources.limits.memory=256Mi \
  --set resources.requests.cpu=50m \
  --set resources.requests.memory=128Mi




  7. FluxCD mit ressourcenschonenden Einstellungen

  # Installation mit minimalen Ressourcen
flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=pi-cluster \
  --branch=main \
  --path=./clusters/staging \
  --personal \
  --timeout=10m

# Sofort danach die Controller optimieren
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: source-controller
  namespace: flux-system
spec:
  template:
    spec:
      containers:
      - name: manager
        resources:
          limits:
            memory: 1Gi
            cpu: 500m
          requests:
            cpu: 100m
            memory: 256Mi
        env:
        - name: SOURCE_ARTIFACT_COMPRESSION
          value: "none"
EOF








8. Wartung und Monitoring

# Wöchentlicher Cleanup für alte Container-Images
sudo tee /etc/cron.weekly/k3s-cleanup << EOF
#!/bin/sh
/usr/local/bin/k3s crictl rmi --prune
EOF

sudo chmod +x /etc/cron.weekly/k3s-cleanup


sudo mkdir -p /etc/systemd/journald.conf.d/
sudo tee /etc/systemd/journald.conf.d/raspi-limits.conf << EOF
[Journal]
SystemMaxUse=100M
RuntimeMaxUse=50M
EOF

sudo systemctl restart systemd-journald




Diese Optimierungen haben zu deinen hervorragenden Ergebnissen geführt:

Nur ~2% CPU-Auslastung auf beiden Nodes
Moderate ~45% RAM-Nutzung bei guter Balance
Stabile Kubernetes-Services ohne Überlastung

Die Kombination aus Hardware-Auswahl, Betriebssystem-Optimierungen, Kernel-Parametern und angepassten K3s-Komponenten hat einen effizienten, stabilen Cluster geschaffen, der trotz der hardwareseitigen Einschränkungen des Raspberry Pi hervorragend für Produktions-Workloads geeignet ist.