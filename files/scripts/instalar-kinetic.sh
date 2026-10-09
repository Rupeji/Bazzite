#!/usr/bin/env bash
set -ox pipefail

# 1. Inyectamos los repositorios Copr con la URL oficial y su ruta larga completa
curl -Lo /etc/yum.repos.d/_copr_theblackdon-kineticwe.repo https://copr.fedorainfracloud.org/coprs/theblackdon/kineticwe/repo/fedora-44/theblackdon-kineticwe.repo

curl -Lo /etc/yum.repos.d/_copr_lionheartp-Hyprland.repo https://copr.fedorainfracloud.org/coprs/lionheartp/Hyprland/repo/fedora-44/lionheartp-Hyprland.repo

# 2. Ejecutamos la sustitución atómica (Sin kdecoration, que causaba el fallo de antes)
rpm-ostree override replace --experimental --from repo=copr:copr.fedorainfracloud.org:theblackdon:kineticwe kwin kwin-common kwin-libs kglobalacceld

# 3. Forzar a Fish como la shell predeterminada del sistema
sed -i 's/\/bin\/bash/\/usr\/bin\/fish/g' /etc/default/useradd

# 4. Inyectar tu usuario de fábrica con la contraseña '1234' para saltar el login
useradd -m -G wheel -s /usr/bin/fish inhumano
echo "inhumano:1234" | chpasswd
