###################################################################
# Dockerfile to build appserv from base to do load test on API requests
# Appserv version: sbt.registry.dev.openbet.com/utils/obmw_profile:0.1
# Modified from base image version: sbt.registry.dev.openbet.com/legacy/base.appserv:9.0.7-4
# Wiki: https://wiki.openbet.com/display/SBT/API+request+profiling
###################################################################

# Set the base image
FROM sbt.registry.dev.openbet.com/utils/obmw_profile:0.1 
# Dockerfile author / maintainer 
MAINTAINER Yi Lu <yi.lu@openbet.com> 

USER root

# Install gnuplot to create output chart
RUN yum update
RUN yum -y install gnuplot
RUN yum -y install openssl
RUN yum -y install curl

# Define working directory.
WORKDIR /opt/openbet/request_profile

# Start testing
#RUN ./run_test

# Start bash
ENTRYPOINT ["/tini" , "--"]
CMD ["/bin/bash"]