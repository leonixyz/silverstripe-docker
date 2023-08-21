FROM alpine:3.21
ADD init.entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && \
    apk update && \
    apk add \
        composer \
        php83-dom \
        php83-fileinfo \
        php83-intl \
        php83-mysqli \
        php83-session \
        php83-simplexml \
        php83-tokenizer \
        php83-xml \
        php83-xmlreader \
        php83-xmlwriter
WORKDIR /app
CMD ["/entrypoint.sh"]
