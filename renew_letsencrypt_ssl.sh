service nginx stop
docker stop apprtc
certbot renew
service nginx stop
docker rm apprtc
pkill -9 nginx
docker run -e PUBLIC_IP=apprtc.privatesmsbox.com -d --name apprtc --restart unless-stopped --net=host -v /etc/letsencrypt/live/apprtc.privatesmsbox.com/privkey.pem:/cert/key.pem -v /etc/letsencrypt/live/apprtc.privatesmsbox.com/fullchain.pem:/cert/cert.pem -v ${PWD}/logs:/webrtc_avconf pegome/apprtc
