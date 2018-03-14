FROM ubuntu:12.04                                                                                                                             
LABEL maintainer "jimmy masias <jimmy.ilws@gmail.com>"

# the cluster needs this in order to 'apt-get update' :P
ARG http_proxy

# Root needs Xorg
RUN apt-get update
RUN apt-get install -y xorg make libnetcdf-dev
# install g++, etc
RUN apt-get install -y build-essential

ARG UID_HOST
ARG GID_HOST
# crear user c/ sudo
#+++++++++++++++++++++++++++++++++++++++++
ENV HOME /home/masiasmj
# add this group to be consistent with the $GID in host
RUN groupadd masiasmj -g ${GID_HOST}
# Add user (user:pass is masiasmj:masiasmj):
# NOTE: the 'wheel' group has to be added by hand into the sudoers file
RUN DOCKER_ENCRYPTED_PASSWORD=`perl -e 'print crypt(masiasmj, "masiasmj"),"\n"'` \
    && useradd -m --uid ${UID_HOST} -G sudo -d ${HOME} -g ${GID_HOST} -p "$DOCKER_ENCRYPTED_PASSWORD" -s /bin/bash masiasmj \
    && echo " %wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# de ahora en adelante, ejecutamos como user=docker
USER masiasmj

ENV PATH="$HOME/root_auger/root/bin:$PATH"
ENV PATH="$HOME/CDAS/CMT/v1r18p20041201/Linux-x86_64:$PATH"
ENV CDAS="$HOME/CDAS"

# append this to ~/.bashrc so that we can load some
# environment variables of Root and CDAS
RUN echo "source $HOME/root_auger/root/bin/thisroot.sh" >> ~/.bashrc \
    && echo "CDASVERSION=\$(basename \$CDAS/version_cdas-*.tgz .tgz | sed -e 's/version_cdas-//' | sed -e 's/p[0-9]//')" >> ~/.bashrc \
    && echo "export CMTVERSION=\$(basename \$CDAS/CMT/*)" >> ~/.bashrc \
    && echo "export CMTROOT=\$CDAS/CMT/\$CMTVERSION" >> ~/.bashrc \
    && echo "export CMTINSTALLAREA=\$CDAS/" >> ~/.bashrc \
    && echo "source \${CMTROOT}/mgr/setup.sh" >> ~/.bashrc \
    && echo "source \$CDAS/Work/\$CDASVERSION/cmt/cdas.sh" >> ~/.bashrc \
    && echo "export CMTPATH=\$CDAS/:\$CDAS/IoFd:\$CMTPATH:\$HOME" >> ~/.bashrc

COPY CDAS $HOME/CDAS
COPY root_auger $HOME/root_auger

# asegurarnos de q tiene el owner correcto
USER root
RUN chown -R masiasmj:masiasmj $HOME/CDAS \
  && chown -R masiasmj:masiasmj $HOME/root_auger

USER masiasmj

#--- re-compiling
# since, the original contents of the CDAS and root_auger directories
# hace been compiled in the original machine 'hegea', they have binaries 
# linked to specific versions of some libraries. So let's recompile in 
# our present machine:
COPY compile_MoIO.sh $HOME/.
RUN $HOME/compile_MoIO.sh
# MoIO is compiled! :D

#EOF
