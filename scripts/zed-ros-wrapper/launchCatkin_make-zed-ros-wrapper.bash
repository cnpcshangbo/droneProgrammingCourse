#!/bin/bash
xhost +si:localuser:root
docker run -it --rm --name catkin_make-script \
	-v ~/catkin_ws:/root/catkin_ws \
	--net host --gpus all --runtime nvidia --privileged -e DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix --entrypoint="" \
	cnpcshangbo/ros-zed-dronekit-cv2:v2 \
	bash -c "source devel/setup.bash && cd /root/catkin_ws && source devel/setup.bash && \
	rosdep install --from-paths src --ignore-src -r -y && \ 
	catkin_make -DCATKIN_WHITELIST_PACKAGES="zed-ros-wrapper" -DCMAKE_BUILD_TYPE=Release -DPYTHON_EXECUTABLE=/usr/bin/python3"      
# installed-cv2-root = cnpcshangbo/ros-zed-dronekit-cv2:v1

