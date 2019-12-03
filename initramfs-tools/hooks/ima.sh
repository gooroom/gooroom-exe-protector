#!/bin/sh

echo "Adding IMA binaries"

. /usr/share/initramfs-tools/hook-functions

copy_exec /usr/share/gooroom/security/gooroom-exe-protector/ima_policy
copy_exec /usr/share/gooroom/security/gooroom-exe-protector/x509_ima.der
copy_exec /bin/keyctl
