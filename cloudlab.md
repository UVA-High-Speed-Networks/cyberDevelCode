# Sender
## Installing `tcpreplay`
To replay traffic to the reciever machine, `tcpreplay` is needed on the sender machine.
To install it:
```
sudo yum groupinstall "Development Tools"
sudo yum install libpcap-devel
wget http://downloads.sourceforge.net/project/tcpreplay/tcpreplay/3.4.4/tcpreplay-3.4.4.tar.gz
tar xvfvz tcpreplay-3.4.4.tar.gz
cd tcpreplay-3.4.4
./configure --enable-dynamic-link
make
sudo make install 
which tcpreplay
which tcprewrite
```

## Finding the connection between sender and reciever
Run `ifconfig` to find device names
ex: `enp1s0f0`,`enp6s0f0`,`lo`
For each of these, run `ethtool <device name>`, ex `ethtool enp1s0f0`
and look in output for `Speed: 10000Mb/s`
	The device that has speed of 10 Gb/s is the link between the machines
You have to do this on the sender and reciever side, note the device name
You also need the corresponding MAC addresses for the noted device names
Run `ifconfig <device name>`, ex `ifconfig enp6s0f0` and look at the output for:
`ether xx:xx:xx:xx:xx:xx` where `x` is a hex character. Record these MAC addresses

## Adding bodies and headers to the CAIDA trace
To replay they CAIDA capture you need to add a body to the packets and rewrite the headers to have the correct MAC addresses as for the source (sender) and destination (reciever)

Adding the MAC headers, you need to use the MAC addresses you recorded for the devices that link the machines

`tcprewrite --enet-dmac=<destination MAC> --enet-smac=<source MAC> --infile=<input pcap>--outfile=<output pcap> --dlt=enet`
ex: `tcprewrite --enet-dmac=90:e2:ba:b3:22:15 --enet-smac=90:e2:ba:b5:03:11 --infile=equinix-sanjose.dirA.20140619-130000.UTC.anon.pcap --outfile=caida1MAC.pcap --dlt=enet`

Adding bodies to the capture

`tcprewrite --fixlen=trunc --infile=<input pcap> --outfile=<output pcap>`
ex: `tcprewrite --fixlen=trunc --infile=caida1MAC.pcap --outfile=caida1final.pcap`

## Sending the traffic to the receiver:
Run
`sudo /path/to/tcpreplay --multiplier=<speed> --intf1=<device> <pcap file>`
ex: `sudo /usr/local/bin/tcpreplay --multiplier=1 --intf1=enp6s0f1 caida1final.pcap`

# Reciever

## Installing PF_RING and bro:

### PF_RING:
```
git clone https://github.com/ntop/PF_RING.git
#make commands for pf_ring
cd PF_RING/userland/lib
./configure --prefix=/opt/pfring
make 
make install

cd ../libpcap
./configure --prefix=/opt/pfring
make install

cd ../tcpdump-4.1.1
./configure --prefix=/opt/pfring
make install

cd ../../kernel
make
make install

modprobe pf_ring enable_tx_capture=0 min_num_slots=32768

cd ../drivers/intel
./configure --prefix=/opt/pfring
sudo make

cd /users/ck2ha0/PF_RING/drivers/intel/ixgbe/ixgbe-5.0.4-zc/src
cp /users/ck2ha0/PF_RING/kernel/linux/pf_ring.h ./pf_ring.h
sudo make install
```
Ensure that huge pages are set up
`echo 1024 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages`

If above gives permission error, write it to a file (huge.sh)
```
chmod +x huge.sh
sudo ./huge.sh
```
restart machine for huge pages changes to take effect
`sudo reboot`

After reboot, load driver (you will need to do this after every reboot)
```
cd /users/ck2ha0/PF_RING/drivers/intel/ixgbe/ixgbe-5.0.4-zc/src
sudo ./load_driver
```

### Bro

```
cd ~
wget https://www.bro.org/downloads/bro-2.5.3.tar.gz
tar -xvzf bro-2.5.3.tar.gz
cd bro-2.5.3
```
Bro has depedencies:
On CentOS:
```
sudo yum install cmake
sudo yum install python-devel
sudo yum install swig
```
On Ubuntu:
```
sudo apt-get install cmake
sudo apt-get install python-dev
sudo apt-get install swig
```
Compile:
```
./configure --with-pcap=/opt/pfring --enable-debug --enable-perftools
make
sudo make install
```

Set up your `node.cfg` in `/usr/local/bro/etc/`

Deploy Bro:
`sudo /usr/local/bro/bin/broctl deploy`

## Running pipeline
Make sure your `node.cfg` is setup correctly. Example using the dummy interface:
```
[logger]
type=logger
host=localhost

[manager]
type=manager
host=localhost

[proxy-1]
type=proxy
host=localhost

[worker-1]
type=worker
host=localhost
interface=dummy0
lb_method=pf_ring
lb_procs=11
pin_cpus=1,2,3,4,5,6,7,8,9,10,11
```


Set up dummy interface:
```
sudo ip link add dummy0 type dummy
sudo ip link set dummy0 up
```
Run zbalance_ipc load balancer
```
cd ~/PF_RING/userland/examples_zc
make zbalance_ipc
sudo ./zbalance_ipc -i zc:enp6s0f0 -c 99 -n 1 -m 1 -g 0 -a -r 0:dummy0 
```
If you re-run zbalance_ipc multiple times, you may get errors like `pfring_zc_create_cluster error`.
To fix, try changing the cluster number (the number after `-c`)

Deploy bro:
`sudo /usr/local/bro/bin/broctl deploy`
Then see the previous section to send the traffic to the reciever (from the sender machine)


## Monitoring
Use `sar`, can be run on sender and reciever side

`sudo yum install sysstat`

`sar -u -d -n DEV 1 | grep <interface>`
ex: `sar -u -d -n DEV 1 | grep enp6s0f0`

Monitor the bro workers on the reciever side
`sudo /usr/local/bro/bin/broctl netstats`

For running these monitoring tools, it may be helpful to use `screen`
`sudo yum install screen`