#!/bin/bash
pushd ~/code/ardupilot/ArduCopter
../Tools/autotest/sim_vehicle.py -v ArduCopter -L Ballarat --mavproxy-args "--out=udpin:0.0.0.0:14552 --state-basedir=/usr/local/home/bsr8w/flightlog --aircraft=copter" --console --map
# -w
popd
