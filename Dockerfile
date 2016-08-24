FROM alpine:3.4

RUN apk add --update ca-certificates

ADD bin/linux_amd64/ngrokd /ngrok/bin/

COPY tools/ngrok.me.crt /server.crt
COPY tools/ngrok.me.key /server.key


ENV DOMAIN **None**
ENV TUNNEL_ADDR :4443
ENV HTTP_ADDR :80
ENV HTTPS_ADDR :443

VOLUME ["/ngrok/bin"]
EXPOSE 4443
EXPOSE 80
EXPOSE 443

CMD /ngrok/bin/ngrokd -tlsKey=/server.key -tlsCrt=/server.crt -domain=${DOMAIN} -httpAddr=${HTTP_ADDR} -httpsAddr=${HTTPS_ADDR} -tunnelAddr=${TUNNEL_ADDR}
