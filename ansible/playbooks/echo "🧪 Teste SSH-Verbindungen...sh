echo "🧪 Teste SSH-Verbindungen..."

ssh p1@192.168.68.52 "hostname && echo 'SSH zu Master (p1) funktioniert ✅'"
ssh p2@192.168.68.56 "hostname && echo 'SSH zu Worker (p2) funktioniert ✅'"
ssh p3@192.168.68.51 "hostname && echo 'SSH zu Data Worker (p3) funktioniert ✅'"

# Falls das ohne Passwort-Eingabe funktioniert, sind SSH-Keys OK ✅