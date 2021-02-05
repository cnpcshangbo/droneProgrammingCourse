xhost +si:localuser:root 
docker run --net host -it --privileged -e DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix --entrypoint="" \
	asciich/mavproxy:latest mavproxy.py --master=/dev/ttyTHS2 --baudrate 921600 --out 127.0.0.1:14550 --out 127.0.0.1:14551 --out 10.106.35.176:14552 --console --map --state-basedir=/home/bo/flightlog --aircraft=copter --load-module=graph
