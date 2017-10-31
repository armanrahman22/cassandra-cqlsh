#!/usr/bin/env bash
echo "HEYYY"
chmod +x /home/wait-for-it.sh # find a way to not need this
# read https://docs.docker.com/compose/startup-order/
./home/wait-for-it.sh cassandra:9042 -- echo "CASSANDRA STARTED"

cqlsh cassandra < ./home/cassandra-setup.cql
cat > sitesettings.csv <<EOF
Puerto Rico,66f22689995d4be38c6f7f9ac7ba249f,80f235db0967430d846bd8f77a22e42a,1dd074f644224107af93967b8b846ca9,es,9,wof,"[18.59033, -68.05771, 17.79565, -65.26262]",2017-10-09 18:41:01.235+0000,"{'en', 'es'}",http://www2.pr.gov/PublishingImages/flags_logo_prgov.png,Puerto Rico,db72531814634cb08469524652ad05a8
EOF

echo "copy fortis.sitesettings from '$(readlink -f sitesettings.csv)';" | cqlsh cassandra