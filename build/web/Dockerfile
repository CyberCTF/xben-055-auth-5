# Overlay of the benchmark's src/Dockerfile (the benchmark is vendored unchanged in app/).
# What differs from upstream:
# - the COPY sources point into app/src/ (this folder is the build context);
# - the FLAG build argument defaults to this lab's fixed flag, the value upstream's Makefile passes (FLAG{sha256 of the benchmark id}), since the spec passes no build arguments.
# Everything else is upstream's, line for line.

FROM php:5-apache

COPY app/src/ .
WORKDIR /var/www/html

ARG FLAG=FLAG{3c8d37d2b7349c6124d67400ab817bed508eb3a155f2a0a1699732b1c120d86e}

RUN sed -i s/@FLAG@/$FLAG/g index.php

EXPOSE 80
