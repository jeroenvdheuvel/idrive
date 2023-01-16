FROM debian:bullseye-slim

LABEL org.opencontainers.image.description="Idrive scripts to backup or restore data"
LABEL org.opencontainers.image.licenses=MIT

RUN apt update && \
    apt-get install -y unzip curl libfile-spec-native-perl libexpat1 libdbd-sqlite3-perl libdbi-perl build-essential perl-doc procps && \
    rm -rf /var/lib/apt/lists/* && \
    cpan install common::sense && \
    cpan install Linux::Inotify2

RUN curl -o IDriveForLinux.zip https://www.idrivedownloads.com/downloads/linux/download-for-linux/IDriveScripts/IDriveForLinux.zip && \
    unzip IDriveForLinux.zip && \
    rm IDriveForLinux.zip && \
    chmod +x IDriveForLinux/scripts/*.pl && \
    mv IDriveForLinux/scripts/* /usr/local/bin/ && \
    rm -rf IDriveForLinux && \
    rm -rf /tmp/*
#RUN curl -o IDriveForLinux.zip https://www.idrivedownloads.com/downloads/linux/download-for-linux/IDriveScripts/IDriveForLinux.zip && \
#    unzip IDriveForLinux.zip && \
#    rm IDriveForLinux.zip && \
#    chmod +x IDriveForLinux/scripts/*.pl && \
#    mv IDriveForLinux/scripts/* /usr/local/bin/ && \
#    rm -rf IDriveForLinux && \
#    printf "/tmp\nn\ny" | /usr/local/bin/check_for_update.pl && \
#    rm -rf /tmp/*

# /usr/bin/perl /usr/local/bin/utility.pl POSTUPDATE 2.29 \
# https://www.idrivedownloads.com/downloads/linux/download-options/idrive_dependency/2.35/k3/x86_64/python.zip -o /usr/local/idriveIt/downloads/python.zip
