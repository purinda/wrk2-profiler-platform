FROM alpine:3.7

USER root

# Install required packages
RUN apk add --update --no-cache bash alpine-sdk linux-headers \
    openssl-dev gnuplot curl python perl git

# Build the latest wrk2
RUN git clone https://github.com/giltene/wrk2.git && cd wrk2 && make
RUN cp wrk2/wrk /usr/local/bin

# Define working directory
WORKDIR /opt/profiler

ENTRYPOINT ["/bin/sh"]