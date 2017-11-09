FROM centos:7.3.1611
ENV MANTAINER "Jimmy J. Masias Meza <jimmy.ilws@gmail.com>"

# install compilers
RUN yum install -y gcc gcc-c++ gcc-gfortran

# utils
RUN yum install -y vim sudo git make wget

# install fftw3
RUN wget http://www.fftw.org/fftw-3.3.5.tar.gz \
    && gunzip fftw-3.3.5.tar.gz \
    && tar -xvf fftw-3.3.5.tar \
    && cd fftw-3.3.5 \
    && ./configure --enable-long-double \
    && make \
    && make install \
    && make distclean \
    && ./configure --enable-single \
    && make \
    && make install \
    && mkdir /software \
    && cd .. \
    && mv fftw-3.3.5 /software/.

# install OpenMPI
RUN yum install -y openmpi openmpi-devel

# fix the locale
# https://www.linuxquestions.org/questions/linux-general-1/locale-cannot-set-lc_all-to-default-locale-no-such-file-or-directory-218622/
RUN localedef -v -c -i en_US -f UTF-8 en_US.UTF-8 || echo " all ok. "

# crear user c/ sudo
#+++++++++++++++++++++++++++++++++++++++++
ENV HomeDocker /home/docker
# Add docker user (user:pass is docker:docker), in case we want to ssh with X:
RUN DOCKER_ENCRYPTED_PASSWORD=`perl -e 'print crypt(docker, "docker"),"\n"'` \
    && useradd -m -G wheel -d ${HomeDocker} -p "$DOCKER_ENCRYPTED_PASSWORD" -s /bin/bash docker


# execute Bash by default
CMD ['/bin/bash']

#EOF
