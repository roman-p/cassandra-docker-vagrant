# cassandra-docker-vagrant
MultiNode MultiDC Cassandra deployment with Vagrant &amp; Docker

## Configuration
To configure your own DC deployment, ssh into a vagrant machine and run the following
```bash
docker run --net=host multidc-cassandra ./run_cassandra.sh <CLUSTER> <SEEDS> <BROADCAST> <DCNAME> <RACKNAME>
```
where
- CLUSTER - Name of Cassandra cluster
- SEEDS - list of Seeds, comma-separated, no spaces
- BROADCAST - Broadcast IP of current node
- DCNAME - Datacenter name of current node
- RACKNAME - Rack name of current node

<br>
You can also configure the private network address, if running on one machine. Also, increasing Virtualbox's container size at least up to 1024M is a good idea
```bash
node10.vm.network "private_network", ip: "BROADCASTIP"
node10.vm.provider "virtualbox" do |v|
 v.memory = 1024
end
```

## Test Setup
**deployment.sh** script in **test** folder starts two Datacenters(3 and 1 nodes respectively) on preconfigured IPs: 
- 192.168.100.111(seed)
- 192.168.100.112
- 192.168.100.113
- 192.168.101.111(seed)
You can run the *testScript.py*, given you have datastax cassandra bindings installed 
