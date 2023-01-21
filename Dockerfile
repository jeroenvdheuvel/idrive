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
    printf "/tmp\nn\ny" | /usr/local/bin/check_for_update.pl && \
    rm /usr/local/bin/.serviceLocation && \
    rm -rf /tmp/* && \
    rm /run/idrive*

CMD ["sh", "-c", "perl /etc/idrivecron.pl"]
