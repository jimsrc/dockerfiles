FROM jimsrc/archlinux:pacaur

# just install the bloody thing so we can have sound!
RUN pacaur -S --no-confirm \
    extra/alsa-utils \
    extra/pulseaudio-alsa \
    extra/alsa-plugins \
    extra/alsa-lib

RUN pacaur -S --noconfirm vivaldi

#EOF
