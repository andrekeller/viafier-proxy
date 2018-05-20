FROM alpine:3.7

RUN apk add --no-cache bash dumb-init nginx ruby && \
    rm -r /etc/nginx/conf.d /etc/nginx/modules && \
    rm /etc/nginx/nginx.conf && \
    chmod 0755 /var/lib/nginx && \
    chmod 0777 /var/tmp/nginx && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    install -d -m 0777 /run/nginx

COPY nginx.conf.erb /etc/nginx
COPY docker-entrypoint.sh /

ENV VIAFIER_STATIC_S3_URL ""
ENV VIAFIER_UPSTREAM "127.0.0.1:8000"

USER nobody

ENTRYPOINT ["dumb-init", "/docker-entrypoint.sh"]
CMD ["nginx"]
