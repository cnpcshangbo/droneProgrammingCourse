#!/bin/bash
xhost +si:localuser:root
docker run -it --rm --name catkin_make-script \
	-v ~/catkin_ws:/opt/ros_ws \
	--net host --gpus all --runtime nvidia --privileged -e DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix --entrypoint="" \
	cnpcshangbo/ros-zed-dronekit-cv2:v2 \
	bash -c "source devel/setup.bash && catkin_make clean"      
# installed-cv2-root = cnpcshangbo/ros-zed-dronekit-cv2:v1

