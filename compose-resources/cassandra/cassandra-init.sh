#!/usr/bin/env bash
chmod +x /init/scripts/wait-for-it.sh
/init/scripts/wait-for-it.sh --timeout=0 cassandra-node1:9042 -- echo "CASSANDRA Node1 started"

cqlsh -f /init/scripts/cassandra-setup.cql cassandra
echo "### SETUP EXECTUED! ###"

# cat > sitesettings.csv <<EOF
# Puerto Rico,66f22689995d4be38c6f7f9ac7ba249f,80f235db0967430d846bd8f77a22e42a,1dd074f644224107af93967b8b846ca9,es,9,wof,"[18.59033, -68.05771, 17.79565, -65.26262]",2017-10-09 18:41:01.235+0000,"{'en', 'es'}",http://www2.pr.gov/PublishingImages/flags_logo_prgov.png,Puerto Rico,db72531814634cb08469524652ad05a8
# EOF

cat > sitesettings.csv <<EOF
America,66f22689995d4be38c6f7f9ac7ba249f,80f235db0967430d846bd8f77a22e42a,1dd074f644224107af93967b8b846ca9,en,9,wof,"[41.5700, -74.5157, 40.4520, -73.5681]",2017-10-09 18:41:01.235+0000,"{'en'}",http://www2.pr.gov/PublishingImages/flags_logo_prgov.png,America,db72531814634cb08469524652ad05a8
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

echo "insert into fortis.streams (pipelinekey, streamid, streamfactory, pipelineicon, pipelinelabel, params, enabled) values ('RSS', uuid(), 'RSS', 'f fa-rss', 'RSS Feeds', { 'feedUrls': 'https://www.boston.com/feed' }, true);" | cqlsh cassandra
echo "insert into fortis.streams (pipelinekey, streamid, streamfactory, pipelineicon, pipelinelabel, params, enabled) values ('RSS', uuid(), 'RSS', 'f fa-rss', 'RSS Feeds', { 'feedUrls': 'http://feeds.washingtonpost.com/rss/politics' }, true);" | cqlsh cassandra
echo "insert into fortis.streams (pipelinekey, streamid, streamfactory, pipelineicon, pipelinelabel, params, enabled) values ('RSS', uuid(), 'RSS', 'f fa-rss', 'RSS Feeds', { 'feedUrls': 'http://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml' }, true);" | cqlsh cassandra

echo "select * from fortis.streams;" | cqlsh cassandra
echo "### FORTIS STREAMS ADDED ###"
echo "### CASSANDRA FINISHED INITIALIZING! ###"


echo "adding terms to watchlist"
echo "insert into fortis.watchlist (topicid, topic, lang_code, translations, category, insertiontime) values (uuid(), 'tax', 'en', {}, 'General', toTimestamp(now()));" | cqlsh cassandra
echo "insert into fortis.watchlist (topicid, topic, lang_code, translations, category, insertiontime) values (uuid(), 'election', 'en', {}, 'General', toTimestamp(now()));" | cqlsh cassandra
echo "insert into fortis.watchlist (topicid, topic, lang_code, translations, category, insertiontime) values (uuid(), 'weinstein', 'en', {}, 'General', toTimestamp(now()));" | cqlsh cassandra
echo "insert into fortis.watchlist (topicid, topic, lang_code, translations, category, insertiontime) values (uuid(), 'kevin spacey', 'en', {}, 'General', toTimestamp(now()));" | cqlsh cassandra
echo "insert into fortis.watchlist (topicid, topic, lang_code, translations, category, insertiontime) values (uuid(), 'spacey', 'en', {}, 'General', toTimestamp(now()));" | cqlsh cassandra
echo "insert into fortis.watchlist (topicid, topic, lang_code, translations, category, insertiontime) values (uuid(), 'ISIS', 'en', {}, 'General', toTimestamp(now()));" | cqlsh cassandra
echo "insert into fortis.watchlist (topicid, topic, lang_code, translations, category, insertiontime) values (uuid(), 'Terrorist', 'en', {}, 'General', toTimestamp(now()));" | cqlsh cassandra
echo "insert into fortis.watchlist (topicid, topic, lang_code, translations, category, insertiontime) values (uuid(), 'New York', 'en', {}, 'General', toTimestamp(now()));" | cqlsh cassandra
echo "insert into fortis.watchlist (topicid, topic, lang_code, translations, category, insertiontime) values (uuid(), 'NYC', 'en', {}, 'General', toTimestamp(now()));" | cqlsh cassandra
echo "insert into fortis.watchlist (topicid, topic, lang_code, translations, category, insertiontime) values (uuid(), 'Trump', 'en', {}, 'General', toTimestamp(now()));" | cqlsh cassandra
echo "insert into fortis.watchlist (topicid, topic, lang_code, translations, category, insertiontime) values (uuid(), 'Houston', 'en', {}, 'General', toTimestamp(now()));" | cqlsh cassandra
echo "insert into fortis.watchlist (topicid, topic, lang_code, translations, category, insertiontime) values (uuid(), 'Flynt', 'en', {}, 'General', toTimestamp(now()));" | cqlsh cassandra

# cat > watchlist.csv <<EOF
# negligente gobierno,es,pr,2017-10-07 16:01:50.635+0000,9ebb662f-0df4-4349-801a-c2a9530ce33b,{'en': 'government negligent'}
# EOF
# echo "copy fortis.watchlist from '$(readlink -f watchlist.csv)';" | cqlsh cassandra

echo "FINISHED ADDING TERMS TO THE WATCHLIST"

# echo negligente gobierno,es,pr,2017-10-07 16:01:50.635+0000,9ebb662f-0df4-4349-801a-c2a9530ce33b,{'en': 'government negligent'} | cqlsh cassandra

# echo "insert into fortis.watchlist (topicid, topic, lang_code, translations, category, insertiontime) values (uuid(), 'Russia', 'en', {}, ,toTimeStamp(now());"
# CREATE TABLE watchlist(
#     topicid uuid,
#     topic text,
#     lang_code text,
#     translations map<text, text>,
#     category text,
#     insertiontime timestamp,
#     PRIMARY KEY ((topic, lang_code), category)
# );

/bin/bash
