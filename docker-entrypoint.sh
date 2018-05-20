#!/bin/bash
set -e

if [[ $1 = 'nginx' ]]; then
    erb /etc/nginx/nginx.conf.erb > /run/nginx/nginx.conf
    nginx -c /run/nginx/nginx.conf
else
    exec "$@"
fi
