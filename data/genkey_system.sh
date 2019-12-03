#!/bin/bash

#
# x509_system.pem 키는 커널컴파일시 포함해야 한다.
# CONFIG_SYSTEM_TRUSTED_KEYS="debian/certs/gooroom_x509_system.pem"
#

if [ $# -eq 0 ]; then
    KEY_PATH=.
else
    if [ -z "$1" ]; then
        echo -e ">>> There is not $1 {KEY_PATH} directory."; exit 1;
    fi
    KEY_PATH=$1
fi

if [ ! -e $KEY_PATH/gooroom_privkey_system.pem ]; then
    openssl req -new -nodes -utf8 -sha256 -days 36500 -batch -x509 \
                -config gooroom_x509_system.genkey \
                -outform DER \
                -out $KEY_PATH/gooroom_x509_system.der \
                -keyout $KEY_PATH/gooroom_privkey_system.pem

    openssl x509 -inform DER \
                 -in $KEY_PATH/gooroom_x509_system.der \
                 -out $KEY_PATH/gooroom_x509_system.pem
fi
