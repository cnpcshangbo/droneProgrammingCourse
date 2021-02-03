#!/bin/bash
# declare STRING variable
STRING="Launch girder detection module in ROS node."

#print variable on a screen
# echo $STRING
# S1=$1
# echo S1= $S1
# S2="svo"
# echo S2= $S2
# if [[ "$S1" == "$S2" ]]; then
# 	echo "working with a svo recording file."
# 	sh ~/code/zed-opencv/test_light_from_ground.sh
# else 
# 	echo "working with physical camera."
# 	python ~/code/zed-opencv/python/zed-opencv.py
# fi 

xhost +si:localuser:root

docker run -it --rm --name my-first-python-script \
	-v /home/bo/code/girder_dronekit_ros/scripts:/home/bo/scripts \
	--net host --gpus all --runtime nvidia --privileged -e DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix --entrypoint="" \
	installed-cv2-root \
	bash -c "source devel/setup.bash && rosrun beginner_tutorials zed-opencv.py"      
# installed-cv2-root = cnpcshangbo/ros-zed-dronekit-cv2:v1
# Expected output: 
# starting up on localhost port 10000                                                                                Press 's' to save Side by side images                                                                             Press 'p' to save Point Cloud                                                                                     Press 'd' to save Depth image                                                                                     Press 'm' to switch Point Cloud format                                                                            Press 'n' to switch Depth format                                                                                 waiting for a connection    

