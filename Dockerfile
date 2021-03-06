FROM alpine:3.4

RUN apk add --update ca-certificates

ADD bin/linux_amd64/ngrokd /ngrok/bin/

COPY tools/server.crt /server.crt
COPY tools/server.key /server.key


ENV DOMAIN **None**
ENV TUNNEL_ADDR :4443
ENV HTTP_ADDR :10080
ENV HTTPS_ADDR :10443

VOLUME ["/ngrok/bin"]
EXPOSE 4443
EXPOSE 10080
EXPOSE 10443

CMD /ngrok/bin/ngrokd -tlsKey=/server.key -tlsCrt=/server.crt -domain=${DOMAIN} -httpAddr=${HTTP_ADDR} -httpsAddr=${HTTPS_ADDR} -tunnelAddr=${TUNNEL_ADDR}
