# docker-corsproxy

This is a simple configuration for a wide open proxy for development with CORS.

## Usage

Environment variables:

```
PROXY_HOST      Required: host to proxy requests to (e.g. https://www.google.com)
EXPOSE_HEADERS  Optional: response headers on the proxy host you want exposed to the client browser (comma separated)
ALLOW_HEADERS   Optional: request headers from the client browser you want exposed to the proxy host (comma separated)
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
