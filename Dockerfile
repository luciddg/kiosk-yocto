# Create an image suited to building Yocto images using the source code
#  provided in the src/ directory and configuration files.

FROM yoctoprep-env
MAINTAINER Brandon Matthews <bmatt@luciddg.com>

# Pro-forma phusion/baseimage support
ENV HOME /root
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
CMD ["/sbin/my_init"]

USER yocto
WORKDIR /usr/local/src/yocto/

RUN git clone -b dizzy git://git.yoctoproject.org/poky.git

# Copy relevant configuration files
# Put the build wrapper script in place

# Clean up APT when done.
USER root
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
