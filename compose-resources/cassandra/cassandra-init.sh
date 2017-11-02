#!/usr/bin/env bash
/init/scripts/wait-for-it.sh cassandra-node1:9042 -- echo "CASSANDRA Node1 started"

cqlsh -f /init/scripts/cassandra-setup.cql cassandra
echo "### SETUP EXECTUED! ###"

cat > sitesettings.csv <<EOF
Puerto Rico,66f22689995d4be38c6f7f9ac7ba249f,80f235db0967430d846bd8f77a22e42a,1dd074f644224107af93967b8b846ca9,es,9,wof,"[18.59033, -68.05771, 17.79565, -65.26262]",2017-10-09 18:41:01.235+0000,"{'en', 'es'}",http://www2.pr.gov/PublishingImages/flags_logo_prgov.png,Puerto Rico,db72531814634cb08469524652ad05a8
EOF
echo "copy fortis.sitesettings from '$(readlink -f sitesettings.csv)';" | cqlsh cassandra

echo "### SITESTREAMS ADDED! ###"

echo "insert into fortis.streams (pipelinekey, streamid, streamfactory, pipelineicon, pipelinelabel, params, enabled) values ('RSS', uuid(), 'RSS', 'f fa-rss', 'RSS Feeds', { 'feedUrls': 'http://www.contextoganadero.com/rss' }, true);" | cqlsh cassandra
echo "insert into fortis.streams (pipelinekey, streamid, streamfactory, pipelineicon, pipelinelabel, params, enabled) values ('RSS', uuid(), 'RSS', 'f fa-rss', 'RSS Feeds', { 'feedUrls': 'http://www.eltiempo.com/rss/bogota.xml' }, true);" | cqlsh cassandra
echo "insert into fortis.streams (pipelinekey, streamid, streamfactory, pipelineicon, pipelinelabel, params, enabled) values ('RSS', uuid(), 'RSS', 'f fa-rss', 'RSS Feeds', { 'feedUrls': 'http://www.eltiempo.com/rss/colombia.xml' }, true);" | cqlsh cassandra
echo "insert into fortis.streams (pipelinekey, streamid, streamfactory, pipelineicon, pipelinelabel, params, enabled) values ('RSS', uuid(), 'RSS', 'f fa-rss', 'RSS Feeds', { 'feedUrls': 'http://www.eltiempo.com/rss/economia.xml' }, true);" | cqlsh cassandra
echo "insert into fortis.streams (pipelinekey, streamid, streamfactory, pipelineicon, pipelinelabel, params, enabled) values ('RSS', uuid(), 'RSS', 'f fa-rss', 'RSS Feeds', { 'feedUrls': 'http://www.eltiempo.com/rss/opinion.xml' }, true);" | cqlsh cassandra
echo "insert into fortis.streams (pipelinekey, streamid, streamfactory, pipelineicon, pipelinelabel, params, enabled) values ('RSS', uuid(), 'RSS', 'f fa-rss', 'RSS Feeds', { 'feedUrls': 'http://www.eltiempo.com/rss/politica.xml' }, true);" | cqlsh cassandra
echo "insert into fortis.streams (pipelinekey, streamid, enabled, params, pipelineicon, pipelinelabel, streamfactory) values ('Twitter', uuid(), True, {'consumerKey': 'ucyxNPXjuXP6Bk2h6RTHsbvSr', 'consumerSecret': 'I52jDoERPthFX3cZVpcqNU18xMFZMYuw1tCx0RuP79eUX6pQBY', 'accessToken': '808417685130321920-Szs6Wytce9W9Pazo7CGSnj0sRA36LoC', 'accessTokenSecret': '9miohljpfd56nTY1mbIk3SnVR7YFOah293Vhu8lQJZFbC'}, 'fa fa-twitter', 'Twitter', 'Twitter');" | cqlsh cassandra

echo "select * from fortis.streams;" | cqlsh cassandra
echo "### FORTIS STREAMS ADDED ###"
echo "### CASSANDRA FINISHED INITIALIZING! ###"

/bin/bash
