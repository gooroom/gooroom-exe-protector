#!/bin/sh

PREREQ=""

# Output pre-requisites

prereqs()
{
    echo "$PREREQ"
}

case "$1" in
    prereqs)
        prereqs
        exit 0
    ;;
esac

ima_id="`awk '/\.ima:/ { printf "%d", "0x"$1; }' /proc/keys`"
cat /usr/share/gooroom/security/gooroom-exe-protector/x509_ima.der | keyctl padd asymmetric '' $ima_id

IMA_POLICY=/sys/kernel/security/ima/policy
LSM_POLICY=/usr/share/gooroom/security/gooroom-exe-protector/ima_policy

if [ -e $LSM_POLICY ] ; then
    grep -v "^#" $LSM_POLICY > $IMA_POLICY
fi
