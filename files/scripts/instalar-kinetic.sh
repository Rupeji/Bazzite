#!/bin/bash
set -oue pipefail

# 1. Descargar los ficheros .repo corregidos de Don de forma directa
curl -Lo /etc/yum.repos.d/_copr_theblackdon-kineticwe.repo https://copr.fedorainfracloud.org/coprs/theblackdon/kineticwe/repo/fedora-44/theblackdon-kineticwe.repo
curl -Lo /etc/yum.repos.d/_copr_lionheartp-Hyprland.repo https://copr.fedorainfracloud.org/coprs/lionheartp/Hyprland/repo/fedora-44/lionheartp-Hyprland.repo

# 2. EL TRUCO DE ORO: Instalar permitiendo que los paquetes de Don reemplacen selectivamente a los del sistema
rpm-ostree install --allow-inactive --allowerasing noctalia kineticwe kitty fish dolphin mpvpaper

# 3. Registrar tu cuenta personal física para saltar el Login Loop
mkdir -p /var/home/inhumano
useradd -d /var/home/inhumano -M -G wheel -s /usr/bin/fish inhumano
echo "inhumano:1234" | chpasswd

# 4. Asignar los permisos del esqueleto del sistema a su nueva casa
cp -r /etc/skel/. /var/home/inhumano/
chown -R inhumano:inhumano /var/home/inhumano
chmod 700 /var/home/inhumano

# 5. Cambiar el esqueleto global de la terminal a Fish
sed -i 's/\/bin\/bash/\/usr\/bin\/fish/g' /etc/default/useradd
