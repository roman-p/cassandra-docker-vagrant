#!/bin/bash
CLUSTER=$1
SEEDS=$2
LISTEN=$3
DC_NAME=$4
RACK_NAME=$5

#wher docker cassandra stores configs 
CONFIG_FOLDER=/etc/cassandra

CONFIG=$CONFIG_FOLDER/cassandra.yaml
CONFIG_DC=$CONFIG_FOLDER/cassandra-rackdc.properties

echo "Modifying config file ..."
echo "CLUSTER=$CLUSTER"
echo "SEEDS=$SEEDS"
echo "LISTEN=$LISTEN"
echo "DC_NAME=$DC_NAME"
echo "RACK_NAME=$RACK_NAME"

#CLUSTER_NAME
sed -i.bak "s/cluster_name: .*/cluster_name: \'$CLUSTER\'/" $CONFIG

# activating data file directories
sed -i.bak "s/[\#\s]*data_file_directories.*\n.*/data_file_directories\:\n \- \/var\/lib\/cassandra\/data\n/" $CONFIG

# Set commit log directory
sed -i.bak "s/[\#\s]*commitlog_directory.*/commitlog_directory\: \/var\/lib\/cassandra\/commitlog/" $CONFIG

#Set saved_caches_directory
sed -i.bak "s/[\#\s]*saved_caches_directory.*/saved_caches_directory\: \/var\/lib\/cassandra\/saved_caches/" $CONFIG

#num_tokens - 256
sed -i.bak "s/num_tokens: .*/num_tokens: 256/" $CONFIG

#seeds
sed -i.bak "s/\- seeds\: .*$/\- seeds\: \"$SEEDS\"/" $CONFIG

# activate listen interface listen_address
sed -i.bak "s/[\# ]*listen_address: .*$/listen_address: $LISTEN/" $CONFIG

#listen_address
sed -i.bak "s/[\# ]*broadcast_address: .*$/broadcast_address: $LISTEN/" $CONFIG

#rpc_address
sed -i -e "s/[\# ]*rpc_address.*$/rpc_address: 0.0.0.0/"  $CONFIG

#broadcast_rpc_address
sed -i -e "s/[\# ]*broadcast_rpc_address.*/broadcast_rpc_address: $LISTEN/"  $CONFIG

#endpoint-snitch
sed -i.bak "s/[\# ]*endpoint_snitch: .*$/endpoint_snitch: GossipingPropertyFileSnitch/" $CONFIG

# auto_bootstrap
echo "auto_bootstrap: false" >> $CONFIG

#change DC and rack info
sed -i.bak "s/^dc=.*/dc=$DC_NAME/" $CONFIG_DC
sed -i.bak "s/^rack=.*/rack=$RACK_NAME/" $CONFIG_DC
sed -i.bak "s/^[\# ]*prefer_local=.*$/prefer_local=true/" $CONFIG_DC

echo "Starting server..."
cassandra -f
