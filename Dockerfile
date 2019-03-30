FROM lsiobase/ubuntu:bionic
LABEL maintainer="Scott <scott.case.1@gmail.com>"

#Add needed nvidia environment variables for https://github.com/NVIDIA/nvidia-docker
ENV NVIDIA_DRIVER_CAPABILITIES="compute,video,utility"

ENV DEBIAN_FRONTEND=noninteractive

#ADD buildffmpeg.sh buildffmpeg.sh
RUN echo "**** update base & install packages ****"
RUN apt-get update && \
    apt-get install -y autoconf automake build-essential libass-dev libfreetype6-dev \
    libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev \
    libxcb-xfixes0-dev libpng-dev pkg-config texinfo zlib1g-dev yasm libmp3lame-dev libxvidcore-dev \
    libopus-dev libxmu-dev freeglut3 freeglut3-dev screen git libfdk-aac-dev libvpx-dev libx264-dev \
    mercurial cmake wget nano tzdata curl bc
RUN echo "**** Done updating base ****"
################################
### Config:
###

# Add pip requirements
COPY /buildffmpeg.sh /tmp/buildffmpeg.sh
RUN chmod +x /tmp/buildffmpeg.sh

COPY /ffmpegMovie /ffmpegMovie
RUN chmod +x /ffmpegMovie

# add local files
COPY root/ /

### Install ffmpeg
RUN echo "**** Install ffmpeg ****" && /tmp/buildffmpeg.sh

### Install pyinotify service.
RUN \
   echo "**** Cleanup ****" \
        && rm -rf \
            /tmp/* \
            /var/tmp/*

####
####ENTRYPOINT ["/ffmpegMovie"]
####