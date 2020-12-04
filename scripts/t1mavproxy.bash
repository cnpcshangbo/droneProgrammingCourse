#!/bin/bash
mavproxy.py --master=udpout:131.151.8.163:14552 --out=0.0.0.0:14551 --console --map --state-basedir=/home/bo/flightlog --aircraft=copter --load-module=graph
# module load graph
# graph ATTITUDE.roll ATTITUDE.pitch

