FROM base/archlinux:2018.01.01
LABEL maintainer "jimsrc <jimmy.ilws@gmail.com>"

RUN pacman -Syu --noconfirm 
RUN pacman -S --noconfirm binutils make gcc curl mpfr pkg-config fakeroot 

# sudo is requirement for pacaur
RUN pacman -S --noconfirm sudo git

#--- instalemos pacaur 
# https://www.ostechnix.com/install-pacaur-arch-linux/
RUN pacman -S expac yajl --noconfirm

# crear user c/ sudo
#+++++++++++++++++++++++++++++++++++++++++
ENV HomeDocker /home/docker
# Add docker user (user:pass is docker:docker):
# NOTE: the 'wheel' group has to be added by hand into the sudoers file
RUN DOCKER_ENCRYPTED_PASSWORD=`perl -e 'print crypt(docker, "docker"),"\n"'` \
    && useradd -m --uid 1000 -G wheel -d ${HomeDocker} -p "$DOCKER_ENCRYPTED_PASSWORD" -s /bin/bash docker \
    && echo " %wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# utils 
# NOTE: we need an editor for pacaur.
RUN pacman -S --noconfirm vi vim

# de ahora en adelante, ejecutamos como user=docker
USER docker

#--- instalar cower & pacaur
# NOTE: necesitamos el "pod2man" (https://github.com/LemonBoy/bar/issues/89) en el PATH
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

RUN pacaur -S aria2 --noconfirm

#EOF
