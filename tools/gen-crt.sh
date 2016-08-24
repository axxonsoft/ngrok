#!/usr/bin/env bash


NGROK_DOMAIN="ngrok.me"

openssl genrsa -out rootCA.key 2048
openssl req -x509 -new -nodes -key rootCA.key -subj "/CN=$NGROK_DOMAIN" -days 5000 -out rootCA.pem
openssl genrsa -out ngrok.me.key 2048
openssl req -new -key ngrok.me.key -subj "/CN=$NGROK_DOMAIN" -out ngrok.me.csr
openssl x509 -req -in ngrok.me.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out ngrok.me.crt -days 5000


cp rootCA.pem ../assets/client/tls/ngrokroot.crt
rm ngrok.me.csr rootCA.srl
