FROM alpine:3.7

USER root

# Install required packages
RUN apk add --update --no-cache bash alpine-sdk linux-headers openssl-dev gnuplot curl python perl git

# Build the latest wrk2
RUN git clone https://github.com/wg/wrk.git && cd wrk && make
RUN cp wrk/wrk /usr/local/bin

# Define working directory
WORKDIR /opt/profiler

ENTRYPOINT ["/bin/sh"]