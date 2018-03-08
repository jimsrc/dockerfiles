# from:
# https://raw.githubusercontent.com/olbat/dockerfiles/master/cupsd/Dockerfile
#ARG MAINTAINER
FROM debian:sid
#MAINTAINER $MAINTAINER

# Install Packages (basic tools, cups, basic drivers, HP drivers)
RUN apt-get update 
RUN apt-get install -y \
	  sudo \
	  whois
RUN apt-get install -y \
	  cups \
	  cups-client \
	  cups-bsd \
	  printer-driver-all \
	  hpijs-ppds \
	  hp-ppd \
	  hplip \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Add user and disable sudo password checking
RUN useradd \
	--groups=sudo,lp,lpadmin \
	--create-home \
	--home-dir=/home/print \
	--shell=/bin/bash \
	--password=$(mkpasswd print) print \
	&& sed -i '/%sudo[[:space:]]/ s/ALL[[:space:]]*$/NOPASSWD:ALL/' /etc/sudoers

# Setup environment
#WORKDIR /home/print

#--- configure
# Follow:
# http://compu.df.uba.ar/impresoras-linux
RUN cp /etc/cups/cupsd.conf /etc/cups/cupsd.conf.old \
	&& sed -i 's/Browsing On/Browsing Off/g' /etc/cups/cupsd.conf \
	&& echo "manual" > /etc/init.d/cups-browsed.override 
#	&& service cups restart \
#	&& lpstat -v \
#	&& lpoptions -d PB 

RUN mkdir /data

USER print
RUN mkdir ~/.cups \
	&& echo 'ServerName print.df.uba.ar' > ~/.cups/client.conf

#CMD [ "service", "cups", "restart" ]
#ENTRYPOINT [ "service", "cups", "restart", "&&", "ps", "aux" ]
CMD service cups restart \
	&& bash -c "while [[ 0 ]]; do sleep 60; done"

#EOF
