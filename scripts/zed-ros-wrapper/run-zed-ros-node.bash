xhost +si:localuser:root
#
# docker run -it \
# 	-v 
# 	cnpcshangbo/pyrealsense-ros-zed-opencv-dronekit:v3 bash
docker exec -it rs-zed-container bash -c \
"source /opt/ros_ws/devel/setup.bash && \
source ~/catkin_ws/devel/setup.bash && \
roslaunch zed_wrapper zed.launch && bash"
