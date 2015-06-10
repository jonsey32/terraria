#! /bin/sh

/confd -onetime -backend env

/usr/bin/supervisord
