#
# Dockerfile for rrshareweb
#

FROM alpine:latest

ENV RRSHARE_URL http://appdown.rrys.tv/rrshareweb_centos7.tar.gz

RUN set -ex \
    && apk add --update --no-cache \
        libstdc++ \
    && wget -q -O /rrshareweb.tar.gz $RRSHARE_URL \
    && tar zxvf /rrshareweb.tar.gz -C /etc/ \
    && rm -rf /rrshareweb.tar.gz \
    && rm -rf /var/cache/apk

VOLUME ["/opt/work/store"]

ENV PATH /etc/rrshareweb:$PATH

EXPOSE 3001

CMD ["rrshareweb"]
