#
# Haproxy Dockerfile
#
#
# Pull base image.
FROM ubuntu:16.04

# Install Haproxy.
RUN \
  apt-get update && \
  apt-get install -y software-properties-common && \
  apt-get install -y python-software-properties && \
  apt-get install -y build-essential && \
  apt-get install -y vim && \
  add-apt-repository ppa:vbernat/haproxy-1.7 && \
  apt-get update && \
  apt-get -y dist-upgrade && \
  apt-get install -y net-tools && \
  apt-get install -y iputils-ping && \
  apt-get install -y libwww-perl && \
  apt-get install -y haproxy && \
  sed -i 's/^ENABLED=.*/ENABLED=1/' /etc/default/haproxy
  #rm -rf /var/lib/apt/lists/*

# Define working directory.
#WORKDIR /etc/haproxy

# Add files.
WORKDIR /
ADD haproxy.cfg  /etc/haproxy/haproxy.cfg
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Define mountable directories.
#VOLUME ["/haproxy-override"]

# Define default command.
CMD ["bash", "/entrypoint.sh"]

# Expose ports.
EXPOSE 8080
EXPOSE 443
