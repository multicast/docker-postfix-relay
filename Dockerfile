#
# Dockerfile
#
FROM mkovac/runit-stretch:latest
MAINTAINER Matej Kovac <matej.kovac@gmail.com>

# files and scripts needed to build the image
#
COPY build /root/build

RUN run-parts --report --exit-on-error /root/build/scripts && \
  rm -rfv /root/build

# only smtp/tcp for now
EXPOSE 25

# these should be persistent
VOLUME ["/var/lib/postfix", "/var/mail", "/var/spool/postfix"]
