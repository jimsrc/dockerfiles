FROM ubuntu:12.04                                                                                                                             
LABEL maintainer "jimmy masias <jimmy.ilws@gmail.com>"

# the cluster needs this in order to 'apt-get update' :P
ARG http_proxy

# Root needs Xorg
RUN apt-get update
RUN apt-get install -y xorg make libnetcdf-dev
# install g++, etc
RUN apt-get install -y build-essential

# crear user c/ sudo
#+++++++++++++++++++++++++++++++++++++++++
ENV HOME /home/masiasmj
# Add docker user (user:pass is docker:docker):
# NOTE: the 'wheel' group has to be added by hand into the sudoers file
RUN DOCKER_ENCRYPTED_PASSWORD=`perl -e 'print crypt(masiasmj, "masiasmj"),"\n"'` \
    && useradd -m --uid 1000 -G sudo -d ${HOME} -p "$DOCKER_ENCRYPTED_PASSWORD" -s /bin/bash masiasmj \
    && echo " %wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# de ahora en adelante, ejecutamos como user=docker
USER masiasmj

ENV PATH="$HOME/root_auger/root/bin:$PATH"
ENV PATH="$HOME/CDAS/CMT/v1r18p20041201/Linux-x86_64:$PATH"
ENV CDAS="$HOME/CDAS"
RUN echo "source $HOME/root_auger/root/bin/thisroot.sh" >> ~/.bashrc \
    && echo "CDASVERSION=\$(basename \$CDAS/version_cdas-*.tgz .tgz | sed -e 's/version_cdas-//' | sed -e 's/p[0-9]//')" >> ~/.bashrc \
    && echo "export CMTVERSION=\$(basename \$CDAS/CMT/*)" >> ~/.bashrc \
    && echo "export CMTROOT=\$CDAS/CMT/\$CMTVERSION" >> ~/.bashrc \
    && echo "export CMTINSTALLAREA=\$CDAS/" >> ~/.bashrc \
    && echo "source \${CMTROOT}/mgr/setup.sh" >> ~/.bashrc \
    && echo "source \$CDAS/Work/\$CDASVERSION/cmt/cdas.sh" >> ~/.bashrc \
    && echo "export CMTPATH=\$CDAS/:\$CDAS/IoFd:\$CMTPATH:\$HOME" >> ~/.bashrc

#ENV ROOTSYS="$HOME/root_auger/root"
#ENV ROOTWCONFIG="Linux-x86_64"
#ENV ROOTWROOT="$HOME/CDAS/RootW/v2r8"
#ENV ROOTEXEC="/bin"

COPY CDAS $HOME/CDAS
COPY root_auger $HOME/root_auger

# asegurarnos de q tiene el owner correcto
USER root
RUN chown -R masiasmj:masiasmj $HOME/CDAS \
  && chown -R masiasmj:masiasmj $HOME/root_auger

USER masiasmj


#EOF
