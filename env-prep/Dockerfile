# Create an image suited to building Yocto images using the source code
#  provided in the src/ directory and configuration files.

FROM phusion/baseimage
MAINTAINER Brandon Matthews <bmatt@luciddg.com>

# Pro-forma phusion/baseimage support
ENV HOME /root
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
CMD ["/sbin/my_init"]

# Add necessary packages for building and generating documentation
#  (from http://www.yoctoproject.org/docs/current/yocto-project-qs/yocto-project-qs.html#ubuntu)
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat libsdl1.2-dev xterm

# bitbake will refuse to run as root, so create a utility user
RUN useradd -d /usr/local/src/yocto --create-home yocto

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
