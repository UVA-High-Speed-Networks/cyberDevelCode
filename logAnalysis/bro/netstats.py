# -*- coding: utf-8 -*-
"""
Created on Wed Mar 14 18:14:17 2018

@author: babraham
"""

import subprocess
import re
import pandas as pd
import time
import math
import os
import sys


def capOutput(cmd):
    try: output = subprocess.Popen(cmd, stdout=subprocess.PIPE ).communicate()[0]
    except: print("couldn't run command")
    return output

def getPacketLoss(waitTime=10):
    cmd = ['broctl', 'netstats']
    ti = time.time()
    startOuptut = capOutput(cmd)
    di = parseNetstatOutput(startOuptut)
    time.sleep(waitTime)
    endOutput = capOutput(cmd)
    df = parseNetstatOutput(endOutput)
    tf = time.time() - ti
    total = df.total.sum() - di.total.sum()
    lost = df.dropped.sum() - di.dropped.sum()
    ploss = float(lost) / float(total)
    pktsps = total  / float(tf)
    print('lost: {}, total: {}'.format(lost,total))
    return {'packetLoss':ploss, 'packetRateBro':pktsps}
    
def parseNetstatOutput(output):
    rx = re.findall('recvd=([0-9]+)', output)
    dropped = re.findall('dropped=([0-9]+)', output)
    total = re.findall('link=([0-9]+)', output)
    df = pd.DataFrame(zip(rx,dropped,total), columns=['received','dropped','total'])
    df = df.apply(pd.to_numeric, axis=0)
    return df
    
def parseProcOutput(output, device = "em1"):
    lines = output.split("\n")
    for i,l in enumerate(lines):
        if device.lower() in l:
            stats = re.findall(' [0-9]+', l)
            byts = int(stats[0].strip())
            pkts = int(stats[1].strip())
            return {'device':device,'bytes':byts, 'packets':pkts}
    return None
        
def getThruput(waitTime = 10, device="em1", units="Gbps"):
    cmd = ['cat', '/proc/net/dev']
    startOutput = capOutput(cmd)
    startDict = parseProcOutput(startOutput)      
    time.sleep(waitTime)
    endOutput = capOutput(cmd)
    endDict = parseProcOutput(endOutput)
    totalbytes = int(endDict['bytes'] - startDict['bytes'])
    if units.lower() == "gbps": thruput = totalbytes * 8 / math.pow(10,9)
    thruput = thruput / waitTime
    totPkts = int(endDict['packets'] - startDict['packets'])
    pktSize = totalbytes / totPkts
    pktRate = totPkts / waitTime
    return {'device':device,
            'throughput':thruput,
            'packetRate':pktRate,
            'packetSize':pktSize}
            
def getAllStats(waitTime = 10, device="em1", units = "Gbps"):
    pLossDict = getPacketLoss(waitTime)
    thruputDict = getThruput(waitTime, device, units)
    resDict = {k:v for k,v in thruputDict.items()}
    for k,v in pLossDict.items(): resDict[k] = v
    return resDict
    
def main():
    ti = time.time()
    tf = 0
    dt = 0
    maxTime = 16
    fname = 'trafficStats.txt'
    #try:
    device = sys.argv[1]
    waitTime = int(sys.argv[2])
#    except:
#        print("""usage: netstats.py --device --waitTime (secs)\n\nexample: netstats.py em1 10""")
#        sys.exit(1)
    if device and waitTime:
        while dt < maxTime:
            res = getAllStats(waitTime, device)
            res['time'] = time.time()
            for k in res.keys(): res[k] = str(res[k])
            #res = sorted(res.items(), key=lambda x:x[0])
            if os.path.isfile(fname):
                out = open(fname, 'a')
            else:
                out = open(fname, 'w')
                out.write(','.join(res.keys())+'\n')
            out.write(','.join(res.values())+'\n')
            out.close()
            tf = time.time()
            dt += tf - ti
            ti = tf
    else:
        print('error parsing arguments')
        sys.exit(1)
        
if __name__ == '__main__':
    main()
            
    
    
old = """  face |bytes    packets errs drop fifo frame compressed multicast|bytes    packets errs drop fifo colls carrier compressed
 team0: 93734223024 141388402    0 1709394    0     0          0  44166651 19029466741 36145422    0    3    0     0       0          0
    lo: 766669606834 971335787    0    0    0     0          0         0 766669606834 971335787    0    0    0     0       0          0
   em2: 217594010987558 254954844276    0 72713761    0     0          0        11     1458      17    0    0    0     0       0          0
   em1: 54912401088209 58199479305    0 198018341    0     0          0         2     1458      17    0    0    0     0       0          0
   em4: 47585923699 72016185    0    0    0     0          0  22914312 4911291077 31706817    0    0    0     0       0          0
   em3: 50630813931 107297624    0    0    0     0          0  21252341 17911475796 39402484    0    0    0     0       0          0
 idrac: 7011296676 19759397    0    0    0     0          0         0 1629048868 22645237    0    0    0     0       0          0"""
  
new = """face |bytes    packets errs drop fifo frame compressed multicast|bytes    packets errs drop fifo colls carrier compressed
 team0: 93734244858 141388490    0 1709394    0     0          0  44166703 19029468600 36145429    0    3    0     0       0          0
    lo: 766788345151 971572907    0    0    0     0          0         0 766788345151 971572907    0    0    0     0       0          0
   em2: 217594010987558 254954844276    0 72713761    0     0          0        11     1458      17    0    0    0     0       0          0
   em1: 54918490462452 58205542697    0 198018570    0     0          0         2     1458      17    0    0    0     0       0          0
   em4: 47585929994 72016207    0    0    0     0          0  22914322 4911293681 31706829    0    0    0     0       0          0
   em3: 50630830702 107297690    0    0    0     0          0  21252383 17911477531 39402499    0    0    0     0       0          0
 idrac: 7011297360 19759409    0    0    0     0          0         0 1629049852 22645251    0    0    0     0       0          0"""
  