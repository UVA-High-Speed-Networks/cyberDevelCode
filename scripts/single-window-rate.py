# -*- coding: utf-8 -*-
"""
Created on Tue Jan 12 15:27:34 2016

@author: souravmaji
"""

from __future__ import division
import matplotlib
matplotlib.use('agg')
import matplotlib.pyplot as plt
import sys
import numpy as np
fal = open(sys.argv[1], 'r')
plotrate = sys.argv[2]

# in most of the pcap runs we have a background traffic of 500 to 700 Mbps. Therefore
# to be fair we are choosing a rate threshold of 350 Mbps (1000 - 700) for the least case ~ 300 Mbps

alpha = fal.readlines()

# Close the file
fal.close()

pktLenAlpha = []
tsAlpha = []
rtAlpha = []
tsAlphaPlot = []

for l in alpha:
    val = l.split(",")
    pktSz = int(val[6])
    ts = float(val[1])
    pktLenAlpha.append(pktSz)
    tsAlpha.append(ts)

tsI=tsAlpha[0]
winBytes = 0
res = 1
for i in xrange(0,len(tsAlpha)):
    winBytes = winBytes + pktLenAlpha[i]
    if(tsAlpha[i] - tsI >= res):
        rate = winBytes*8/((tsAlpha[i] - tsI)*1e6) 
        tsI = tsAlpha[i+1]
        winBytes = 0
 	rtAlpha.append(rate)
        tsAlphaPlot.append(tsAlpha[i])

plt.plot(tsAlphaPlot, rtAlpha)
plt.xlabel('Time in sec')
plt.ylabel('Rate in Mbps')
plt.legend(['alpha'], loc='upper left')
plt.savefig(plotrate + ".png")
