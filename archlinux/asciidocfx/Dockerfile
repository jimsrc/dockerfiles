FROM jimsrc/arch_pacaur:25feb2018

# install deps
RUN pacaur -S --noconfirm \
    extra/gtk2 \
    extra/ttf-freefont

# install asciidocfx
#RUN pacaur -S --noconfirm asciidocfx \
#    || echo -e "\n [*] deps installed.\n"

# download "pacman-repo" of asciidocfx
RUN pacaur -S --noconfirm asciidocfx --download 
# modify the PKGBUILD so that we can pull 
# the latest version of asciidocfx (see _commitId).
# Intall deps, then download the Git repo && install :)
RUN cd ~/.cache/pacaur/asciidocfx \
    && sed -i "s/^_commitId=.*/_commitId=\'561c98b7aae9c7583ab5e9ffce06be0e92cf02ee\'/g" PKGBUILD \
    && sed -i "s/e817c96fa3.*512/\'0f8319d529e28b5edeae27d4c7d31b2b017d0c385e118a65a52ffda372da5baa6fb46f7236668aae912245f660e9fb9721ec390f0f32e11fc05ec6f577e6b748\'/g" PKGBUILD \
    && sed -i "s/pkgver=1.5.6/pkgver=1.5.9/g" PKGBUILD \
    && sed -i "s/install .*\.desktop/#&/g" PKGBUILD \
    && makepkg --noconfirm -o -s \
    && makepkg --noconfirm --noextract -s -i

#EOF
