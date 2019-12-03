#!/bin/bash

if [ $# -eq 0 ]; then
    export KEY_PATH=.
    export vendor_name=v3
elif [ -z "$1" ] || [ -z "$2" ] ; then
    echo -e ">>> $0 <KEY_PATH> <csr_v3_ima name>"
    exit 1;
else
    export KEY_PATH=$1
    export vendor_name=$2
fi

if [ -e $KEY_PATH/csr_${vendor_name}_ima.pem ]; then
    openssl x509 -req -in $KEY_PATH/csr_ima.pem -days 36500 \
                 -extfile ima_extension \
                 -extensions v3_usr \
                 -CA $KEY_PATH/gooroom_x509_system.pem \
                 -CAkey $KEY_PATH/gooroom_privkey_system.pem \
                 -CAserial gooroom_x509_system.srl \
                 -outform DER \
                 -out $KEY_PATH/x509_${vendor_name}_ima.der
else
    echo "$KEY_PATH/csr_${vendor_name}_ima.pem is not exist !!!"
fi
