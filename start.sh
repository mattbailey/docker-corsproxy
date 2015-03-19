#!/usr/bin/env bash

# Ngnix does not support vars at all in 
#  directives (e.g. location) so I've had to resort to this.
#  Don't bother asking for this feature from them,
#  they refuse to implement it.

# This is to support APIs that don't conform to the "unspoken rules" 
#   of REST APIs that endpoints that represent collections should not have
#   a trailing slash. Some of these will 301/302 redirect,
#   e.g. /foo > 301 > /foo/, but this breaks CORS with preflight errors.
# If you set this env variable, it will create an nginx directive that will
#   proxy, rather than re-direct these endpoints. e.g.:
#   docker run (...) -e API_RECTIFY='foo|bar' will create a location directive
#   to proxy /foo and /bar to /foo/ and /bar/
[[ -n "$API_RECTIFY" ]] && sed -ie "s/API_RECTIFY/${API_RECTIFY}/" /etc/nginx/nginx.conf

# Runtime
nginx -g 'daemon off;'
