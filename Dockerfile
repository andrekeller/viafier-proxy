FROM alpine:3.13

RUN apk add --no-cache bash dumb-init nginx ruby && \
    rm -r /etc/nginx/conf.d /etc/nginx/modules && \
    rm /etc/nginx/nginx.conf && \
    chmod 0755 /var/lib/nginx && \
    chmod 0777 /var/lib/nginx/tmp && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    install -d -m 0777 /run/nginx

COPY nginx.conf.erb /etc/nginx
COPY docker-entrypoint.sh /

ENV VIAFIER_UPSTREAM "127.0.0.1:8000"
ENV VIAFIER_INVENTORY_DOMAIN "viafier.com"
ENV VIAFIER_INVENTORY_LOCATION "inventory/configurations"
ENV VIAFIER_S3_ENDPOINT ""
ENV VIAFIER_S3_MEDIA_BUCKET ""
ENV VIAFIER_S3_STATIC_BUCKET ""
ENV VIAFIER_S3_CACHE_MEDIA "yes"
ENV VIAFIER_S3_CACHE_STATIC "yes"

USER nobody
VOLUME /var/lib/nginx-cache

ENTRYPOINT ["dumb-init", "/docker-entrypoint.sh"]
CMD ["nginx"]
