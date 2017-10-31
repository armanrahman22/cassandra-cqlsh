chmod +x /init/scripts/wait-for-it.sh
/init/scripts/wait-for-it.sh cassandra-node1:9042 -- echo "CASSANDRA Node1 started"
cqlsh -f /init/scripts/cassandra-setup.cql cassandra
echo "### CASSANDRA INITIALISED! ###"