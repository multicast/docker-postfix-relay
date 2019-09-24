#
# Dockerfile
#
FROM mkovac/runit-buster:latest
LABEL MAINTAINER="matej.kovac@gmail.com"

# files and scripts needed to build the image
#
COPY build /root/build

ARG CACHE_DATE=1970-01-01
RUN run-parts --report --exit-on-error /root/build/scripts && \
  rm -rfv /root/build

# only smtp/tcp for now
EXPOSE 25

# these should be persistent
VOLUME ["/var/lib/postfix", "/var/mail", "/var/spool/postfix"]

ENTRYPOINT ["/sbin/entrypoint.sh"]

CMD ["/usr/bin/runsvdir", "-P", "/etc/runit/runsvdir/default"]
