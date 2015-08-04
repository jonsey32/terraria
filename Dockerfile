FROM ubuntu:14.04

MAINTAINER Emil Haugbergsmyr <emil@raeven.net>

VOLUME ["/world", "/config", "/logs"]

ENV WORLD_NAME docker
ENV MAX_PLAYERS 16
ENV IP 0.0.0.0
ENV PORT 7777

# Add mono repository
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list

# Update os and install required applications
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y zip mono-complete supervisor curl

# Install confd
RUN curl -qL https://github.com/kelseyhightower/confd/releases/download/v0.9.0/confd-0.9.0-linux-amd64 -o /confd && chmod +x /confd
RUN mkdir -p /etc/confd/conf.d
RUN mkdir -p /etc/confd/templates

# Download and install TShock software
ADD https://github.com/NyxStudios/TShock/releases/download/v4.3.7/tshock_4.3.7-pre1.zip /
RUN unzip tshock_4.3.7-pre1.zip -d /tshock
RUN rm tshock_4.3.7-pre1.zip

COPY supervisord.tmpl /etc/confd/templates/supervisord.tmpl
COPY supervisord.toml /etc/confd/conf.d/supervisord.toml

ADD run.sh /
RUN chmod u+x /run.sh

EXPOSE 7777

CMD ["/run.sh"]
