FROM gliderlabs/alpine:3.6

USER root

# Install required packages
RUN apk add --update alpine-sdk openssl-dev gnuplot curl
RUN apk add --no-cache git

# Build the latest wrk2
RUN git clone https://github.com/giltene/wrk2.git && cd wrk2 && make
RUN cp wrk2/wrk /usr/local/bin

# Define working directory
WORKDIR /opt/profiler