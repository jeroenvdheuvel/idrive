FROM debian:bullseye-slim

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
    printf "/tmp\nn\ny" | /usr/local/bin/check_for_update.pl && \
    rm -rf /tmp/*
