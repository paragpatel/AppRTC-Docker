#!/bin/bash
ip=`hostname -i`

if [ "$1" != "" ] ; then
	ip=$1
fi
docker stop webrtc
sleep 1
docker rm webrtc
sleep 1
#docker run --rm --net=host -e PUBLIC_IP=`hostname -i` -it webrtc
#for linux
docker run --name webrtc -d --rm --net=host -e PUBLIC_IP=$ip  -v ${PWD}/webrtc_avconf:/webrtc_avconf -it webrtc
#for mac
#docker run --rm -d --name webrtc -e PUBLIC_IP=$ip -p 442:443 -p 8089:8089 -p 3478:3478 -p 3478:3478/udp -p 3033:3033 -p 59000-59100:59000-59100/udp -v ${PWD}/webrtc_avconf:/webrtc_avconf -it webrtc
