# Create an image suited to building Yocto images using the source code
#  provided in the src/ directory and configuration files.

# Because volumes aren't first-class citizens in Dockerfiles,
#  n.b. that the build script expects a host mount at
#  /usr/local/share/yocto/

FROM yoctoprep-env
MAINTAINER Brandon Matthews <bmatt@luciddg.com>

# Pro-forma phusion/baseimage support
ENV HOME /root
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
CMD ["/sbin/my_init"]

WORKDIR /usr/local/src/yocto/

RUN git clone -b dizzy git://git.yoctoproject.org/poky.git

# Copy relevant configuration files
ADD build/ /usr/local/src/yocto/build/

# Put the build wrapper script in place
ADD build-yocto.sh /usr/local/src/yocto/

# Clean up APT when done.
USER root
# Workaround Docker bug #7537
RUN chown -R yocto:yocto /usr/local/src/yocto/

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
