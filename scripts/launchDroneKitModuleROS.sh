#!/bin/bash
# declare STRING variable
STRING="Launch DroneKit module."
#print variable on a screen
echo $STRING
# python ~/code/droneProgrammingCourse/dk/velocity_based_movement.py

docker run -it --rm --name ros-dronekit-in-docker \
	-v ~/catkin_ws:/root/catkin_ws \
	--net host --gpus all --runtime nvidia --privileged -e DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix --entrypoint="" \
	cnpcshangbo/ros-zed-dronekit-cv2:v2 \
	bash -c "source devel/setup.bash && cd /root/catkin_ws && source devel/setup.bash && rosrun beginner_tutorials velocity_based_movement.py"      
# installed-cv2-root = cnpcshangbo/ros-zed-dronekit-cv2:v1
