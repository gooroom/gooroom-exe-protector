#!/bin/bash

if [ $# -eq 0 ]; then
    KEY_PATH=.
else
    if [ -z "$1" ]; then
        echo -e ">>> There is not $1 {KEY_PATH} directory."; exit 1;
    fi
    KEY_PATH=$1
fi

if [ ! -e $KEY_PATH/privkey_ima.pem ]; then
    openssl req -new -nodes -utf8 -sha256 \
                -days 36500 -batch \
                -config ima.genkey \
                -out $KEY_PATH/csr_ima.pem \
                -keyout $KEY_PATH/privkey_ima.pem
fi

if [ -e $KEY_PATH/csr_ima.pem ]; then
    openssl x509 -req -in $KEY_PATH/csr_ima.pem -days 36500 \
                 -extfile ima_extension \
                 -extensions v3_usr \
                 -CA $KEY_PATH/gooroom_x509_system.pem \
                 -CAkey $KEY_PATH/gooroom_privkey_system.pem \
                 -CAserial $KEY_PATH/gooroom_x509_system.srl \
                 -CAcreateserial \
                 -outform DER \
                 -out $KEY_PATH/x509_ima.der
else
    echo "$KEY_PATH/csr_ima.pem is not exist !!!!"
fi
