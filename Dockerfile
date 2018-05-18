# sshd, node, zsh, and forever to run service.
#
# VERSION               0.1.0
# this version provides:
#       a node evironment for future automation.

FROM     ubuntu
LABEL maintainer="joseph.balsamo@stonybrook.edu"

# build with
#  sudo docker build --rm=true -t="repo/imgname" .

### update
RUN apt-get -q update
RUN apt-get -q -y upgrade
RUN apt-get -q -y dist-upgrade
RUN apt-get clean
RUN apt-get -q update

# OpenSSH server
RUN apt-get -q -y install openssh-server

### need build tools for building openslide and later iipsrv
RUN apt-get -q -y install sudo git curl libtool zsh nodejs npm vim
RUN sudo sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

RUN mkdir /root/src

RUN npm install -g yarn
RUN npm install -g forever


WORKDIR /root/src

### git Clone needed folders and copy into final destination.
RUN git clone https://github.com/SBU-BMI/lymph_pipeline.git
RUN git clone https://github.com/SBU-BMI/uploadHeatmaps.git

### Todo: Refactor to use a local copy of scripts that makes sense.
RUN ln -s /root/src/uploadHeatmaps/uploadHeatmaps.sh /usr/local/bin/uploadHeatmaps.sh
RUN ln -s /root/src/lymph_pipeline/download_heatmap/download_markings/download_markings_weights.sh /usr/local/bin/download_markings_weights.sh
RUN ln -s /root/src/lymph_pipeline/download_heatmap/download_markings/get_formatted_mark.sh /usr/local/bin/get_formatted_mark.sh
RUN ln -s /root/src/lymph_pipeline/download_heatmap/download_markings/get_formatted_weight.sh /usr/local/bin/get_formatted_weight.sh
RUN ln -s /root/src/lymph_pipeline/download_heatmap/download_markings/raw_data_formating.awk /usr/local/bin/raw_data_formating.awk
RUN chmod u+x /root/src/lymph_pipeline/download_heatmap/download_markings/*.sh /root/src/uploadHeatmaps/uploadHeatmaps.sh

### Expose port
#EXPOSE 3000

## setup a mount point for images.  - this is external to the docker container.
RUN mkdir -p /mnt/xfer
RUN mkdir -p /mnt/config
RUN mkdir -p /mnt/data

CMD ["/bin/bash"]
