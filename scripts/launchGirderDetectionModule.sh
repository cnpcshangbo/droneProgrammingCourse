#!/bin/bash
# declare STRING variable
STRING="Launch girder detection module."
#print variable on a screen
echo $STRING
S1=$1
echo S1= $S1
S2="svo"
echo S2= $S2
if [[ "$S1" == "$S2" ]]; then
	echo "working with a svo recording file."
	sh ~/code/zed-opencv/test_light_from_ground.sh
else 
	echo "working with physical camera."
	python3 ~/code/zed-opencv/python/zed-opencv.py
fi 

