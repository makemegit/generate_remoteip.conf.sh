#!/bin/bash

echo "# Generate/Update /etc/apache2/conf-available/remoteip.conf for CloudFlare" > /etc/apache2/conf-available/remoteip.conf
echo "# More Information: https://developers.cloudflare.com/support/troubleshooting/restoring-visitor-ips/restoring-original-visitor-ips/ " >> /etc/apache2/conf-available/remoteip.conf
echo "" >> /etc/apache2/conf-available/remoteip.conf

echo "RemoteIPHeader CF-Connecting-IP" >> /etc/apache2/conf-available/remoteip.conf

curl https://www.cloudflare.com/ips-v4/ > /tmp/tempv4
curl https://www.cloudflare.com/ips-v6/ > /tmp/tempv6

sed -i -e 's/^/RemoteIPTrustedProxy /' /tmp/tempv4
sed -i -e 's/^/RemoteIPTrustedProxy /' /tmp/tempv6

cat /tmp/tempv4 >> /etc/apache2/conf-available/remoteip.conf
echo '' >> /etc/apache2/conf-available/remoteip.conf
cat /tmp/tempv6 >> /etc/apache2/conf-available/remoteip.conf
echo "" >> /etc/apache2/conf-available/remoteip.conf

rm -f /tmp/tempv*

service apache2 restart
