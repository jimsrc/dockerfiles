FROM base/archlinux:latest

#+++++++++++++++++++++ BEGIN: update system
ARG VERSION_DATE

RUN pacman -Syu --noconfirm 
#+++++++++++++++++++++ END: update system


#+++++++++++++++++++++ BEGIN: pacaur
# we must inherit this user ID to avoid any trouble with
# permissions when downloading stuff into mounted volumes of
# the container.
ARG UID_HOST

RUN pacman -S --noconfirm \
    binutils \
    make \
    gcc \
    curl \
    mpfr \
    pkg-config \
    fakeroot \
    sudo \
    git \
    vi \
    vim

#--- dependencies for pacaur 
# https://www.ostechnix.com/install-pacaur-arch-linux/
RUN pacman -S --noconfirm \
    expac \
    yajl 

#--- crear user c/ sudo
ENV HomeDocker /home/docker
# Add docker user (user:pass is docker:docker):
# NOTE: the 'wheel' group has to be added by hand into the sudoers file
RUN DOCKER_ENCRYPTED_PASSWORD=`perl -e 'print crypt(docker, "docker"),"\n"'` \
    && useradd -m --uid ${UID_HOST} -G wheel -d ${HomeDocker} -p "$DOCKER_ENCRYPTED_PASSWORD" -s /bin/bash docker \
    && echo " %wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# from now on, execute as user=docker
USER docker

#--- install cower & pacaur
# NOTE: we need the "pod2man" (https://github.com/LemonBoy/bar/issues/89) in the PATH
RUN export PATH="/usr/bin/core_perl:$PATH" \
    && mkdir ~/tmp \
    && cd ~/tmp \
    && gpg --recv-keys --keyserver hkp://pgp.mit.edu 1EB2638FF56C0C53 \
    && curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=cower \
    && makepkg -i PKGBUILD --noconfirm \
    && makepkg -s -i --noextract \
    && curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=pacaur \
    && makepkg -i PKGBUILD --noconfirm \
    && makepkg -s -i --noextract \
    && rm -rf ~/tmp

#--- install yaourt (just in case). About ~1MB increase in the image.
RUN pacaur -S yaourt --noconfirm
#+++++++++++++++++++++ END: pacaur


#+++++++++++++++++++++ BEGIN: vivaldi
# just install the bloody thing so we can have sound!
RUN pacaur -S --noconfirm \
    extra/alsa-utils \
    extra/pulseaudio-alsa \
    extra/alsa-plugins \
    extra/alsa-lib

RUN pacaur -S --noconfirm vivaldi
#+++++++++++++++++++++ END: vivaldi

#EOF
