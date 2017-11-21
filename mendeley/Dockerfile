FROM ubuntu:16.04
MAINTAINER jimmy.ilws@gmail.com

# ~82MB
RUN apt-get update \
    && apt-get -y upgrade 

# heavy block (~160MB)
RUN apt-get install -y gconf2 libglu1-mesa 

# another heavy block (~260MB)
RUN apt-get install -y python-pip

# ~18MB
RUN pip install -U lxml 

# some of these libraries might not be necessary! (~ 119MB in total)
RUN apt-get install -y \
    libxslt1-dev libxrender1 libxcomposite1 \
    libcupsmime1 libcupsmime1-dev \
    libgtk2.0-0 libnss3 libidn11 libpango1.0-0 libpangox-1.0-0 libpangoxft-1.0-0 libxft2 \
    libasound2 libxtst6 liborc-0.4-0 \
    libqt5dbus5 libice6 libqt5gui5

# ~2MB
RUN apt install -y wget

# ~370MB (even removing the installer file)
RUN wget https://www.mendeley.com/repositories/ubuntu/stable/amd64/mendeleydesktop-latest \
    && dpkg -i mendeleydesktop-latest \
    && rm mendeleydesktop-latest

# create a user with UID==1000 (same as my host UID, so modify as needed)
RUN DOCKER_ENCRYPTED_PASSWORD=`perl -e 'print crypt(docker, "docker"),"\n"'` \
    && useradd -m --uid 1000 -G sudo -p "$DOCKER_ENCRYPTED_PASSWORD" -s /bin/bash docker

# now we can execute 
# mendeleydesktop ## :)))) Happy Reading!

#EOF
