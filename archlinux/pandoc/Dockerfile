FROM base/archlinux:2018.02.01
LABEL maintainer "jimmy masias <jimmy.ilws@gmail.com>"

# NOTE: pass the value of this ARG with the CLI argument --build-arg. For
# example:
#       docker build -t <tag-for-docker-image> \
#           --build-arg VERSION_DATE=`date +%d%b%Y` <Dockerfile-directory>
# This "ARG" line is to force the build to bifurcate the container 
# image at this point, and build a new layer.
ARG VERSION_DATE

RUN pacman -Syu --noconfirm 
RUN pacman -S --noconfirm binutils make gcc curl mpfr 
RUN pacman -S --noconfirm pkg-config fakeroot
RUN pacman -S --noconfirm sudo git vi vim

#--- para luego instalar pacaur 
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

# install pandoc (w/ 300MB of Haskell dependency nonsense)
RUN pacaur -S --noconfirm community/pandoc

#EOF
