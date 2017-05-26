#

FROM alpine:latest

MAINTAINER "Hiroaki Sano <hiroaki.sano.9stories@gmail.com>"

ENV USERNAME tor
ENV VERSION 0.3.0.7

RUN adduser -D -g '' -u 1000 -h /home/${USERNAME} ${USERNAME}
RUN chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}

RUN apk add --no-cache gcc g++ python make curl ca-certificates libevent-dev openssl-dev && \
  update-ca-certificates && \
  curl -o tor-${VERSION}.tar.gz -sSL https://www.torproject.org/dist/tor-${VERSION}.tar.gz && \
  tar xvfz tor-${VERSION}.tar.gz && \
  cd tor-${VERSION} && \
  ./configure --prefix=/tor && \
  make && \
  make install && \
  rm -rf /var/cache/apk/* /tor-${VERSION}.tar.gz /tor-${VERSION}

RUN install -m 755 -g ${USERNAME} -o ${USERNAME} -d /tor && \
  install -m 755 -g ${USERNAME} -o ${USERNAME} -d /tor/var/log/tor && \
  install -m 755 -g ${USERNAME} -o ${USERNAME} -d /tor/var/lib/tor

COPY torrc /tor/etc/tor/torrc

EXPOSE 9001 9030

USER tor
CMD ["/tor/bin/tor"]

