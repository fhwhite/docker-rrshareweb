#
# Dockerfile for rrshareweb
#

FROM alpine:3.8

ENV GLIBC_VER 2.30-r0
ENV GLIBC_URL https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk
ENV GLIBC-BIN_URL https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk
ENV RRSHARE_URL http://appdown.rrys.tv/rrshareweb_centos7.tar.gz

RUN set -ex \
    && apk add --no-cache --virtual .run-deps \
        libstdc++ \
    && apk add --no-cache --virtual .build-deps \
        wget \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    && wget $GLIBC_URL \
    && wget $GLIBC-BIN_URL \
    && apk add --no-cache \
        glibc-${GLIBC_VER}.apk \
		glibc-bin-${GLIBC_VER}.apk \
    && rm -rf glibc* \
    && wget $RRSHARE_URL \
    && tar zxvf rrshareweb_centos7.tar.gz -C /etc/ \
    && rm -rf rrshareweb_centos7.tar.gz \
    && apk del .build-deps \
    && rm -rf /var/cache/apk

ENV PORT  3001 

EXPOSE $PORT

CMD ["rrshareweb]