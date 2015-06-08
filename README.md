# docker-syncthing

This is a docker image for a [Terraria](https://terraria.org/) game server.

##Install

    $ docker pull raeven/terraria

##Usage
    
    $ docker run -d -p 7777:7777 raeven/terraria

Start the server with the world outside of the container for storage

    $ docker run -d -p 7777:7777 -v /my/terraria:/world raeven/terraria

*   `-d` will run the container in the background.
*   `-p` will expose ports on the host and bind them to ports in the container.
*   `-v` will mount your a directory on the host to a volume in the container.
*   `raeven/terraria` the name of this docker image. 

Each time you run the container it will generate new keys and a new device ID.
