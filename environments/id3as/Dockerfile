FROM phusion/passenger-full:0.9.10

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

## Install an SSH of your choice.
#ADD your_key /tmp/your_key
#RUN cat /tmp/your_key >> /root/.ssh/authorized_keys && rm -f /tmp/your_key
# --OR--
# Uncomment this to enable the insecure key.
# https://github.com/phusion/baseimage-docker/blob/master/image/insecure_key
#RUN /usr/sbin/enable_insecure_key


# ================================================== #
#                 id3as setup steps                  #
# ================================================== #

RUN apt-get update
RUN apt-get upgrade --fix-missing -y

RUN apt-get install -y software-properties-common
RUN apt-get install -y python-software-properties

RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test

RUN apt-get update
RUN apt-get upgrade --fix-missing -y

RUN apt-get install -y wget
RUN apt-get install -y git
RUN apt-get install -y build-essential
RUN apt-get install -y gcc-4.8
RUN apt-get install -y g++-4.8
RUN apt-get install -y libncurses5-dev
RUN apt-get install -y openssl
RUN apt-get install -y libssl-dev
RUN apt-get install -y curl
RUN apt-get install -y openssh-server
RUN apt-get install -y supervisor
RUN apt-get install -y m4
RUN apt-get install -y make
RUN apt-get install -y sudo
RUN apt-get install -y yasm
RUN apt-get install -y gawk
RUN apt-get install -y libbz2-dev
RUN apt-get install -y libasound2-dev
RUN apt-get install -y tmux
RUN apt-get install -y python-pip
RUN pip install awscli

# ================================================== #
#                   RSA && Github                    #
# ================================================== #


ENV GIT_COMMITTER_NAME robashton
ENV GIT_AUTHOR_NAME robashton
ENV GIT_COMMITTER_EMAIL robashton@codeofrob.com
ENV GIT_AUTHOR_EMAIL robashton@codeofrob.com

RUN adduser id3as

# Enable to test your cert setup
#RUN ssh -T git@github.com

#RUN dpkg --list | grep compiler
#RUN cc

# ================================================== #
#                       Erlang                       #
# ================================================== #

RUN mkdir -p /opt/erlang/
RUN curl -O https://raw.githubusercontent.com/spawngrid/kerl/master/kerl && chmod a+x kerl
RUN mv kerl /opt/erlang/
RUN ln -s /opt/erlang/kerl /usr/local/bin/kerl
RUN kerl update releases


RUN KERL_CONFIGURE_OPTIONS=--enable-hipe kerl build 17.0 17.0
RUN kerl install 17.0 /opt/erlang/17.0

ENV PATH /opt/erlang/17.0/bin:$PATH

# Install Rebar
RUN cd /opt/erlang && git clone git://github.com/rebar/rebar.git
RUN cd /opt/erlang/rebar && ./bootstrap
RUN ln -s /opt/erlang/rebar/rebar /usr/local/bin/rebar

# Install relx
RUN cd /opt/erlang && git clone git://github.com/erlware/relx.git
RUN cd /opt/erlang/relx && make
RUN ln -s /opt/erlang/relx/relx /usr/local/bin/relx


# ================================================== #
#                    Native deps                     #
# ================================================== #

ADD ssh/ /root/.ssh/
RUN chmod 700 /root/.ssh/id_rsa

ENV NATIVEDEPSDIR /nativedeps
ENV PREFIX $NATIVEDEPSDIR/bin
RUN mkdir -p $NATIVEDEPSDIR


# X264
RUN cd $NATIVEDEPSDIR              && git clone git@github.com:id3as/x264.git
RUN cd $NATIVEDEPSDIR/x264         && ./configure --enable-static --prefix=$PREFIX
RUN cd $NATIVEDEPSDIR/x264         && make && sudo make install



# LIBFDK_AAC
RUN cd $NATIVEDEPSDIR               && wget http://sourceforge.net/projects/opencore-amr/files/fdk-aac/fdk-aac-0.1.1.tar.gz/download && tar xf download
RUN cd $NATIVEDEPSDIR/fdk-aac-0.1.1 && ./configure --prefix=$PREFIX
RUN cd $NATIVEDEPSDIR/fdk-aac-0.1.1 && make && sudo make install
RUN cd $NATIVEDEPSDIR               && rm download



# MAINCONCEPT codec
RUN cd $NATIVEDEPSDIR               && git clone git@github.com:id3as/MainConceptVC1Codec
RUN cd $NATIVEDEPSDIR               && sudo ln -s "`pwd`/MainConceptVC1Codec/demo_codec_sdk_linux_x64_release/lib/libdemo_enc_vc1.so" $PREFIX/lib/libdemo_enc_vc1.so
RUN cd $NATIVEDEPSDIR               && sudo ln -s "`pwd`/MainConceptVC1Codec/demo_codec_sdk_linux_x64_release/lib/libdemo_enc_vc1.so" $PREFIX/lib/libmc_enc_vc1.so



# LIBAV on Linux
RUN cd $NATIVEDEPSDIR               && git clone git@github.com:id3as/libav.git
RUN cd $NATIVEDEPSDIR/libav         && ./configure --enable-static --enable-libx264 --enable-gpl --enable-libfdk-aac --enable-nonfree --enable-libmcvc1 --extra-cflags="-I$NATIVEDEPSDIR/MainConceptVC1Codec/demo_codec_sdk_linux_x64_release/include -I$NATIVEDEPSDIR/bin/include" --extra-ldflags="-L$NATIVEDEPSDIR/MainConceptVC1Codec/demo_codec_sdk_linux_x64_release/lib -L$NATIVEDEPSDIR/bin/lib/" --prefix=$PREFIX
RUN cd $NATIVEDEPSDIR/libav         && make && sudo make install



ENV C_INCLUDE_PATH $NATIVEDEPSDIR/bin/include
ENV LIBRARY_PATH= $NATIVEDEPSDIR/bin/lib
ENV LD_LIBRARY_PATH $NATIVEDEPSDIR/bin/lib
ENV PATH $PREFIX/bin:$PREFIX/lib:$PATH

ENV SOURCEDIR /src
RUN mkdir $SOURCEDIR

# ================================================== #
#                     ssh access                     #
# ================================================== #

RUN /usr/sbin/enable_insecure_key
EXPOSE 22

# ================================================== #
#          copy udp ping back to host file           #
# ================================================== #

CMD /usr/sbin/sshd -D

# Various build tools
RUN npm install -g browserify
RUN npm install -g stylus
RUN npm install -g nodemon


# ================================================== #
#                     clean up                       #
# ================================================== #

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

