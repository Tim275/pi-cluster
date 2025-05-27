# SSH-Keys zu allen 3 Pis übertragen (wird nach Passwort fragen)
echo "🎯 Übertrage SSH-Keys zu Master Pi (p1)"
ssh-copy-id p1@192.168.68.52
# Passwort für p1 eingeben

echo "🎯 Übertrage SSH-Keys zu Worker Pi (p2)" 
ssh-copy-id p2@192.168.68.56
# Passwort für p2 eingeben

echo "🎯 Übertrage SSH-Keys zu Data Worker Pi (p3)"
ssh-copy-id p3@192.168.68.51  
# Passwort für p3 eingeben