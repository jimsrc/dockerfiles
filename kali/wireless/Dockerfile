FROM kalilinux/kali-linux-docker:latest

# some persistent personalization for
# the workflow
ADD ./home/.bashrc      /root/.
ADD ./home/.profile     /root/.

# NOTE: pass the value of this ARG with the CLI argument --build-arg. For
# example:
#       docker build -t <tag-for-docker-image> \
#           --build-arg VERSION_DATE=`date +%d%b%Y` <Dockerfile-directory>
# This "ARG" line is to force the build to bifurcate the container 
# image at this point, and build a new layer with all the upgrades of 
# the system (openssl, tor-browser, etc), by executing the 'pacman -Syu'. 
ARG VERSION_DATE

#--- update/upgrade the system
#RUN wget -q -O - https://archive.kali.org/archive-key.asc | apt-key add \
#    && apt-get update && apt-get upgrade
RUN apt-key adv --keyserver hkp://keys.gnupg.net --recv-keys 7D8D0BF6 \ 
    && apt-get update \
    && apt-get upgrade -y

#--- basic framework
RUN apt-get install -y kali-linux-wireless

#--- useful stuff
RUN apt-get install -y proxychains traceroute inetutils-telnet \
    ftp geoip-bin 

#--- shodan API
RUN apt-get install -y python-setuptools \
    && easy_install --upgrade setuptools click shodan

#--- tor stuff
RUN apt-get install -y torsocks tor 


################################################
# WARNING: this is a point where the Docker 
# image stack bifurcate to grab the latest updates.
################################################
# NOTE: pass the value of this ARG with the CLI argument --build-arg. For
# example:
#       docker build -t <tag-for-docker-image> \
#           --build-arg VERSION_DATE=`date +%d%b%Y` <Dockerfile-directory>
# This "ARG" line is to force the build to bifurcate the container 
# image at this point, and build a new layer with all the upgrades of 
# the system (openssl, tor-browser, etc), by executing the 'pacman -Syu'. 
# The kernel version of course should be updated in the host.
#ARG VERSION_DATE
#
#RUN apt-get update && apt-get upgrade

#EOF
