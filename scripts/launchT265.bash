#/bin/bash
echo "Run t265 scripts."
# docker exec -it rs-zed-container bash -c "source devel/setup.bash && cd /root/catkin_ws && source devel/setup.bash && rosrun beginner_tutorials velocity_based_movement.py"
docker exec -it rs-zed-container bash /root/code/vision_to_mavros/scripts/t265.sh
