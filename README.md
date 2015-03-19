# docker-corsproxy

This is a simple configuration for a wide open proxy for development with CORS.

## Usage

Environment variables:

```
PROXY_HOST      Required: host to proxy requests to (e.g. https://www.google.com)
EXPOSE_HEADERS  Optional: response headers on the proxy host you want exposed to the client browser (comma separated)
ALLOW_HEADERS   Optional: request headers from the client browser you want exposed to the proxy host (comma separated)
API_RECTIFY     Optional: form: 'foo|bar', would proxy /foo and /bar to /foo/ and /bar/, this is to fix poorly planned APIs
```

Example:

```
docker run --rm -t \
  -e PROXY_HOST=https://www.google.com \
  -e ALLOW_HEADERS=X-MyCustom-API-Key,X-Some-Token \
  -e EXPOSE_HEADERS=X-Some-Response-Token
  -p 8080:80 \
  mattbailey/docker-corsproxy
```

## CORS

The CORS settings here are WIDE OPEN, meaning it can be XHR'd from any Origin, for any standard HTTP method.  Secure accordingly, this is really only meant for development & testing.

## API_RECTIFY

This requires some more explanation, and is the unfortunate requirement driving having to use a start.sh rather than directly running nginx.

This is to support APIs that don't conform to the "unspoken rules" of REST APIs that endpoints that represent collections should not have a trailing slash. Some of these will 301/302 redirect, e.g. /foo > 301 > /foo/, but this breaks CORS with preflight errors.

If you set this env variable, it will create an nginx directive that will proxy, rather than re-direct these endpoints. e.g.: docker run (...) -e API_RECTIFY='foo|bar' will create a location directive to proxy /foo and /bar to /foo/ and /bar/
