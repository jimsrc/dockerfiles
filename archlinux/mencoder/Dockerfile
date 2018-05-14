FROM ubuntu:16.04

ARG BUILD_DATE

RUN echo "deb http://us.archive.ubuntu.com/ubuntu trusty main universe" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get upgrade -y

# build animations .mpg
RUN apt-get install mencoder -y
# to convert from .mpg to .gif
RUN apt-get install ffmpeg -y


#EOF
