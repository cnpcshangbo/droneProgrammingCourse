#/bin/bash
echo "Run t265 scripts."
# docker exec -it rs-zed-container bash -c "source devel/setup.bash && cd /root/catkin_ws && source devel/setup.bash && rosrun beginner_tutorials velocity_based_movement.py"
# docker exec -it --privileged rs-zed-container bash -c "export PYTHONPATH=$PYTHONPATH:/usr/local/lib:/usr/local/lib/python3.6/pyrealsense2 && source /root/code/vision_to_mavros/scripts/t265.sh"

docker run -it --rm --net=host --privileged -v /home/bo/code/vision_to_mavros:/root/code/vision_to_mavros cnpcshangbo/pyrealsense-ros-zed-opencv-dronekit:v3 bash -c "export PYTHONPATH=$PYTHONPATH:/usr/local/lib:/usr/local/lib/python3.6/pyrealsense2 && source /root/code/vision_to_mavros/scripts/t265.sh"
