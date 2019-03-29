#!/bin/bash

git clone https://git.videolan.org/git/ffmpeg/nv-codec-headers.git
#git clone -b sdk/8.2 https://git.videolan.org/git/ffmpeg/nv-codec-headers.git
cd nv-codec-headers
make
make install
cd ..

wget http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 &> /dev/null
tar xjvf ffmpeg-snapshot.tar.bz2 &> /dev/null
cd ffmpeg

./configure \
--extra-cflags=-I/usr/local/cuda/targets/x86_64-linux/include \
--extra-ldflags=-L/usr/local/cuda/targets/x86_64-linux/lib64 \
--extra-cflags=-Ilocal/include \
--enable-cuda \
--enable-cuvid \
--enable-nvenc \
--enable-nonfree \
--disable-shared \
--enable-gpl \
--enable-libass \
--enable-libfdk-aac \
--enable-libfreetype \
--enable-libmp3lame \
--enable-libopus \
--enable-libtheora \
--enable-libvorbis \
--enable-libvpx \
--enable-libxvid \
--enable-version3 
make -j 10 &> /dev/null
make install

cp /usr/local/bin/ffmpeg ffmpeg_binary/
cp /usr/local/bin/ffprobe ffmpeg_binary/