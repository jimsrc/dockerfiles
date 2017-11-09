FROM ubuntu:16.04
LABEL mantainer "Jimmy Masías <jimmy.ilws@gmail.com>"

# update 
RUN apt-get update 

#+++++++++++++++++++++++++++++++++++++++++
# utils #01
RUN apt-get install -y sudo vim git curl wget

# utils #02: install vim && configs/plugins

# utils #03: install tmux?



#+++++++++++++++++++++++++++++++++++++++++
# Add docker user (user:pass is docker:docker), in case we want to ssh with X:
RUN DOCKER_ENCRYPTED_PASSWORD=`perl -e 'print crypt(docker, "docker"),"\n"'` \
    && useradd -m -G sudo -d ${HomeDocker} -p "$DOCKER_ENCRYPTED_PASSWORD" -s /bin/bash docker


#EOF
