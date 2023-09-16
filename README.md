# AppRTC Docker with SSL

Linux:
``` bash
docker run -e PUBLIC_IP=<server public domain/IP> \
--net=host \
-v ${PWD}/letsencrypt/privkey.pem:/cert/key.pem \
-v ${PWD}/letsencrypt/fullchain.pem:/cert/cert.pem \
-v ${PWD}/logs:/webrtc_avconf \
pegome/apprtc
```

Mac:
``` bash
docker run -e PUBLIC_IP=<server public domain/IP> \
-p 442:443 -p 8089:8089 -p 3478:3478 -p 3478:3478/udp -p 3033:3033 -p 59000-59100:59000-59100/udp \
-v ${PWD}/letsencrypt/privkey.pem:/cert/key.pem \
-v ${PWD}/letsencrypt/fullchain.pem:/cert/cert.pem \
-v ${PWD}/logs:/webrtc_avconf \
pegome/apprtc
```
Note: you need SSL key and cert for your domain to work this docker.


## Manual build AppRTC server Linux host (must have docker installed):
+ Copy files to your Linux host: git clone https://github.com/Shark-y/WebRTC-Docker rtc
+ Navigate to: apprtc-server then chmod +x *.sh
+ Run the bash commands below
+ Update SSL key-pebble.pem and cert-pebble.pem for you domain.
+ Open https://MYDOMAIN/

``` bash
$ mkdir rtc
$ git clone https://github.com/paragpatel/AppRTC-Docker rtc
$ cd rtc/apprtc-server
$ chmod +x *.sh
$ sudo ./build.sh         # Build the docker image - docker build -t webrtc . (takes 5mins to build)
$ sudo ./docker-run.sh    # create SSL certs for hostname and start servers
```

About port publish:

+ TCP `443` is used for room server;
+ TCP `8089` is used for signal server;
+ TCP `3033` is used for ICE server;
+ TCP `3478`, UDP `3478` and UDP `59000-59100` is used for TURN/STUN server;

So make sure your firewall has opened those ports.
