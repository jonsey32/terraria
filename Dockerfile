FROM ubuntu:14.04

MAINTAINER Emil Haugbergsmyr <emil@raeven.net>

VOLUME ["/world", "/config", "/logs"]

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y zip mono-complete supervisor

ADD https://github.com/NyxStudios/TShock/releases/download/v4.2.10/tshock_4.2.10.zip /
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN unzip tshock_4.2.10.zip
RUN rm tshock_4.2.10.zip

EXPOSE 7777

CMD ["/usr/bin/supervisord"]
