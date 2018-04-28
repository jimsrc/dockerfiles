FROM base/archlinux:latest
LABEL maintainer "jimsrc <jimmy.ilws@gmail.com>"

ARG VERSION_DATE
RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm binutils make gcc curl mpfr pkg-config fakeroot sudo git vi vim

#--- instalemos pacaur 
# https://www.ostechnix.com/install-pacaur-arch-linux/
RUN pacman -S expac yajl --noconfirm

# crear user c/ sudo
#+++++++++++++++++++++++++++++++++++++++++
ARG UID_HOST
ENV HomeDocker /home/docker
# Add docker user (user:pass is docker:docker):
# NOTE: the 'wheel' group has to be added by hand into the sudoers file
RUN DOCKER_ENCRYPTED_PASSWORD=`perl -e 'print crypt(docker, "docker"),"\n"'` \
    && useradd -m --uid ${UID_HOST} -G wheel -d ${HomeDocker} -p "$DOCKER_ENCRYPTED_PASSWORD" -s /bin/bash docker \
    && echo " %wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# de ahora en adelante, ejecutamos como user=docker
USER docker

#--- instalar cower & pacaur
# NOTE: necesitamos el "pod2man" (https://github.com/LemonBoy/bar/issues/89) en el PATH
# NOTE: i can use the GNUPGHOME variable instead of exxecuting `gpg --recv-key`
RUN export PATH="/usr/bin/core_perl:$PATH" \
    && export GNUPGHOME="/etc/pacman.d/gnupg" \
    && mkdir ~/tmp \
    && cd ~/tmp \
    && curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=cower \
    && makepkg -i PKGBUILD --noconfirm \
    && makepkg -s -i --noextract \
    && curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=pacaur \
    && makepkg -i PKGBUILD --noconfirm \
    && makepkg -s -i --noextract \
    && rm -rf ~/tmp

#--- install yaourt (just in case). About ~1MB increase in the image.
RUN pacaur -S yaourt --noconfirm

#--- install tor browser
RUN gpg --recv-keys --keyserver hkp://pgp.mit.edu D1483FA6C3C07136 \
    && pacaur -S aur/tor-browser-en-us --noconfirm

#--- update && upgrade the system
# NOTE: pass the value of this ARG with the CLI argument --build-arg. For
# example:
#       docker build -t <tag-for-docker-image> \
#           --build-arg VERSION_DATE=`date +%d%b%Y` <Dockerfile-directory>
# This "ARG" line is to force the build to bifurcate the container 
# image at this point, and build a new layer with all the upgrades of 
# the system (openssl, tor-browser, etc), by executing the 'pacman -Syu'. 
# The kernel version of course should be updated in the host.

#RUN pacaur -Syu --noconfirm

#EOF
