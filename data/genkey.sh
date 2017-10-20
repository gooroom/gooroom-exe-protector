#!/bin/bash

if [ $# -eq 0 ]; then
    KEY_PATH=.
else
    if [ ! -e $1 ]; then
        echo -e ">>> There is not $1 {KEY_PATH} directory."; exit 1;
    fi
    KEY_PATH=$1
fi

if [ ! -e $KEY_PATH/privkey_evm.pem ]; then
    openssl req -new -nodes -utf8 -sha1 \
                -days 36500 \
                -batch -x509 \
                -config x509_evm.genkey \
                -outform DER \
                -out $KEY_PATH/x509_evm.der \
                -keyout $KEY_PATH/privkey_evm.pem

    openssl rsa -pubout -in $KEY_PATH/privkey_evm.pem -out $KEY_PATH/pubkey_evm.pem
fi
