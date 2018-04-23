# jack morris 04/23/18
#
# this script takes the output of many iterations of `ifconfig [device]` and produces graphs 
# of the received packet counts and packet drop counts
#
# thanks to https://regexr.com/

import matplotlib
import matplotlib.pyplot as plt
import re

# open file
ifconfig_file = 'ifconfig_log_201804191644'
ifconfig_log = open(ifconfig_file + '.txt').read()

# find packets received counts
packets_received_pattern = 'RX packets \d+' # ex: RX packets 593172039626
packets_received_raw = re.findall(packets_received_pattern, ifconfig_log) 
packet_counts = [x.split(' ')[2] for x in packets_received_raw]
print 'p', packet_counts

# find drop counts
drop_counts_pattern = 'RX errors \d  dropped \d+' # ex: RX errors 0  dropped 1379026519
drop_counts_raw = re.findall(drop_counts_pattern, ifconfig_log)
drop_counts = [x.split(' ')[5] for x in drop_counts_raw]
print 'd', drop_counts

assert(len(packets_received_raw) == len(drop_counts_raw))

def output_for_excel(packets_received_raw, drop_counts_raw):
	for _i in xrange(len(packets_received_raw)):
		print _i, packets_received_raw[_i].split(' ')[2], drop_counts_raw[_i].split(' ')[5]

def plot_graphs(packet_counts, drop_counts):
	fig, ax1 = plt.subplots()
	t = range(0, 60)
	ax1.plot(t, packet_counts, 'b-') # b- ?
	ax1.set_xlabel('minute')
	ax1.set_ylabel('cumulative packets received', color='b')
	ax1.tick_params('y', colors='b')
	ax1.set_yticklabels(['{:,}'.format(int(x)) for x in ax1.get_yticks().tolist()])


	ax2 = ax1.twinx()
	ax2.plot(t, drop_counts, 'r-')
	ax2.set_ylabel('cumulative packets dropped', color='r')
	ax2.tick_params('y', colors='r')

	# plt.savefig('test.png')
	fig.tight_layout()
	plt.savefig(ifconfig_file + '.png')
	plt.show()

plot_graphs(packet_counts, drop_counts)
# output_for_excel(packets_received_raw, drop_counts_raw)
