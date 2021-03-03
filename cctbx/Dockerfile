
FROM ubuntu:18.04
LABEL maintainer="Johannes Blaschke <jpblaschke@lbl.gov>"
# adapted from Rollin Thomas <rcthomas@lbl.gov>
# and Kelly Rowland <kellyrowland@lbl.gov>

# Base Ubuntu packages

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8

RUN \
    apt-get update          &&                                                 \
    apt-get --yes upgrade   &&                                                 \
    apt-get --yes install                                                      \
        bzip2                                                                  \
        curl                                                                   \
        git                                                                    \
        libffi-dev                                                             \
        lsb-release                                                            \
        tzdata                                                                 \
        vim                                                                    \
        wget                                                                   \
        bash                                                                   \
        autoconf                                                               \
        automake                                                               \
        gcc                                                                    \
        g++                                                                    \
        make                                                                   \
        cmake                                                                  \
        gfortran                                                               \
        tar                                                                    \
        unzip                                                                  \
        strace                                                                 \
        patchelf                                                               \
        libgl1-mesa-dev                                                        \
        libgtk2.0-0                                                            \
        x11-xserver-utils

# Timezone to Berkeley

ENV TZ=America/Los_Angeles
RUN \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime  &&  \
    echo $TZ > /etc/timezone


#-------------------------------------------------------------------------------
# SHELL and WORKDIR
#
# The /opt/ scripts require source => switch `RUN` to execute bash (instead sh)
#

SHELL ["/bin/bash", "-c"]
WORKDIR /img

#-------------------------------------------------------------------------------


RUN mkdir -p /img
COPY . /img

RUN cd /img                                                                 && \
    ./opt/get_mamba_linux-64.sh

RUN cd /img                                                                 && \
    source utilities.sh                                                     && \
    mk-env mpich
   
RUN cd /img                                                                 && \
    source utilities.sh                                                     && \
    mk-cctbx

RUN cd /img                                                                 && \
    source utilities.sh                                                     && \
    patch-dispatcher nersc
 

#-------------------------------------------------------------------------------
# LDCONFIG
#
# We recommend running an /sbin/ldconfig as part of the image build (e.g. in
# the Dockerfile) to update the cache after installing any new libraries in in
# the image build.
#

RUN /sbin/ldconfig

#-------------------------------------------------------------------------------


#-------------------------------------------------------------------------------
# ENTRYPOINT
#

RUN chmod +x entrypoint.sh

ENTRYPOINT ["/img/entrypoint.sh"]

#-------------------------------------------------------------------------------
