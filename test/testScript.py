from cassandra.cluster import Cluster
import cassandra

cluster = Cluster(['192.168.100.111'])
session = cluster.connect()

#having 3 nodes in Datacenter1 and 1 node in Datacenter2
#session.execute("CREATE KEYSPACE test_space WITH REPLICATION = { 'class' : 'NetworkTopologyStrategy', 'Datacenter1' : 2, 'Datacenter2' : 1 };")
#session.execute("CREATE TABLE test_space.test_table (myID int PRIMARY KEY, someNumber int)")

insert_query_command = "INSERT INTO test_space.test_table (myID, someNumber) VALUES (%s, %s)"
insert_query = cassandra.query.SimpleStatement(insert_query_command,
	consistency_level=cassandra.ConsistencyLevel.EACH_QUORUM)

select_query_command = "Select * from test_space.test_table"
select_global_query = cassandra.query.SimpleStatement(select_query_command,
	consistency_level=cassandra.ConsistencyLevel.LOCAL_QUORUM)

#test input/output
for myID, someNumber in enumerate([10,273,102020,144,12385,-364,0]):
    session.execute(insert_query, [myID, someNumber])

all_results = session.execute(select_global_query)

for myID, someNumber in all_results:
	print myID, someNumber
