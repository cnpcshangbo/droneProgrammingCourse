#!/bin/bash
cd ~/ardupilot/ArduCopter
sim_vehicle.py -L Ballarat --mavproxy-args "--out=udpin:0.0.0.0:14552 --state-basedir=/usr/local/home/bsr8w/flightlog --aircraft=copter" --console --map
