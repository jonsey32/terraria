FROM ubuntu:14.04

MAINTAINER Emil Haugbergsmyr <emil@raeven.net>

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y zip mono-complete supervisor

ADD https://github.com/NyxStudios/TShock/releases/download/v4.2400/TShock.4.2.4.0128.zip /
COPY serverconfig.txt /config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN unzip TShock.4.2.4.0128.zip
RUN rm TShock.4.2.4.0128.zip

VOLUME ["/world", "/config", "/logs"]

EXPOSE 7777

CMD ["/usr/bin/supervisord"]
