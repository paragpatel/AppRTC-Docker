#PUBLIC_IP=`hostname`

sed -i "s/SERVER_PUBLIC_IP/${PUBLIC_IP}/g" /ice.js
sed -i "s/SERVER_PUBLIC_IP/${PUBLIC_IP}/g" /apprtc/out/app_engine/constants.py

# vsilva
# Generate ssl certs for domain
#echo "Generating SSL certs for domain $PUBLIC_IP"
# domain=$PUBLIC_IP
# openssl req -subj "/CN=$domain/O=C1AS/C=US" -newkey rsa:2048 -sha256 -nodes -keyout $domain-key.pem -out $domain.csr -outform PEM
# openssl req -in $domain.csr -text -noout -verify
# openssl x509 -req -in $domain.csr -CA /cert/cert-pebble.pem -CAkey /cert/key-pebble.pem -CAcreateserial -text -out $domain.pem -days 1024 -sha256

# copy to proper place (collider WS server)
# mv $domain.pem /cert/cert.pem
# mv $domain-key.pem /cert/key.pem

# apache2 SSL (deprecated)
#cp /cert/key.pem  /etc/ssl/private/ssl-cert-snakeoil.key
#cp /cert/cert.pem /etc/ssl/certs/ssl-cert-snakeoil.pem

#echo Starting apache server
#service apache2 start

echo "************ STARTUP ******************"
echo "* PUBLIC_IP=${PUBLIC_IP}"
echo "* Open https://${PUBLIC_IP}"
echo "***************************************"
mkdir /webrtc_avconf
nodejs /apprtc/ice.js &>/webrtc_avconf/ice_server.log &
/goWorkspace/bin/collidermain -port=8089 -tls=true --room-server=0.0.0.0 &> /webrtc_avconf/collider.log &
dev_appserver.py /apprtc/out/app_engine --skip_sdk_update_check --enable_host_checking=False --host=0.0.0.0 --ssl_certificate_path=/cert/cert.pem --ssl_certificate_key_path=/cert/key.pem --specified_service_ports default:442 &> /webrtc_avconf/apprtc_rs.log &
turnserver -v -L 0.0.0.0 -a -f -r apprtc -c /etc/turnserver.conf --no-tls --no-dtls
#supervisord -c /apprtc_supervisord.conf

