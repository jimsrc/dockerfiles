FROM lamp/auger:hegea

# we need wget
USER root
RUN apt-get install -y wget

# back to normal privileges
USER masiasmj
WORKDIR $HOME

COPY conda/conda_installer.sh $HOME/.

# download installer && install Miniconda && remove installer
RUN wget -c http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh \
    && chmod +x ./conda_installer.sh \
	&& chmod +x Miniconda-latest-Linux-x86_64.sh \
    && ./conda_installer.sh ./Miniconda-latest-Linux-x86_64.sh /condadir \
	&& rm Miniconda-latest-Linux-x86_64.sh 

# we are supposed to use *this* Python
ENV PATH "/condadir/bin:$PATH"	

# copy the "hegea" requirements 
COPY requirements.txt .

# this is the conda version in "hegea"
RUN conda install -y -c anaconda conda=4.2.12 

# install the requirements using the channels that I used
RUN conda install -y \
    -c anaconda -c nmoraitakis -c yoavram -c trung -c astropy -c auto -c defaults \
    --file $HOME/requirements.txt

#EOF
