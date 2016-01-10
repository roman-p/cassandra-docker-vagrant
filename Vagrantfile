Vagrant.configure("2") do |config|
  config.vm.box = 'ubuntu/trusty64'
  config.vm.define "node10" do |node10|
    node10.vm.provision "docker" do |d|
      d.build_image "/vagrant/install",
        args: "-t multidc-cassandra "
      d.run "cassdc1n0",
        auto_assign_name: false,
        args: "--name cass10 --net=host multidc-cassandra ./run_cassandra.sh MyTestCluster 192.168.100.111,192.168.101.111 192.168.100.111 Datacenter1 R1"
    end
    node10.vm.network "private_network", ip: "192.168.100.111"
    node10.vm.provider "virtualbox" do |v|
      v.memory = 1024
    end
  end

  config.vm.define "node11" do |node11|
    node11.vm.provision "docker" do |d|
      d.build_image "/vagrant/install",
        args: "-t multidc-cassandra "
      d.run "cassdc1n1",
        auto_assign_name: false,
        args: "--name cass11 --net=host multidc-cassandra ./run_cassandra.sh MyTestCluster 192.168.100.111,192.168.101.111 192.168.100.112 Datacenter1 R1"
    end
    node11.vm.network "private_network", ip: "192.168.100.112"
    node11.vm.provider "virtualbox" do |v|
      v.memory = 1024
    end
  end

  config.vm.define "node12" do |node12|
    node12.vm.provision "docker" do |d|
      d.build_image "/vagrant/install",
        args: "-t multidc-cassandra "
      d.run "cassdc1n2",
        auto_assign_name: false,
        args: "--name cass12 --net=host multidc-cassandra ./run_cassandra.sh MyTestCluster 192.168.100.111,192.168.101.111 192.168.100.113 Datacenter1 R1"

        d.build_image "/vagrant/test",
        args: "-t test-cassandra "
    end
    node12.vm.network "private_network", ip: "192.168.100.113"
    node12.vm.provider "virtualbox" do |v|
      v.memory = 2048
    end
  end

  config.vm.define "node20" do |node20|
    node20.vm.provision "docker" do |d|
      d.build_image "/vagrant/install",
        args: "-t multidc-cassandra "
      d.run "cassdc2n0",
        auto_assign_name: false,
        args: "--name cass21 --net=host multidc-cassandra ./run_cassandra.sh MyTestCluster 192.168.100.111,192.168.101.111 192.168.101.111 Datacenter2 R1"
    end
    node20.vm.network "private_network", ip: "192.168.101.111"
    node20.vm.provider "virtualbox" do |v|
      v.memory = 1024
    end
  end

end
