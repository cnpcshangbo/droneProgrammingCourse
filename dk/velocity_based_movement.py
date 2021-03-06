##########DEPENDENCIES#############

from dronekit import connect, VehicleMode,LocationGlobalRelative,APIException
import time
import datetime
import socket

import sys

# import exceptions
try:
            import exceptions
except ImportError:
            import builtins as exceptions
import math

import argparse
from pymavlink import mavutil
#########FUNCTIONS#################

def connectMyCopter():

#	parser = argparse.ArgumentParser(description='commands')
#	parser.add_argument('--connect')
#	args = parser.parse_args()

#	connection_string = args.connect

#	if not connection_string:
#		import dronekit_sitl
#		sitl = dronekit_sitl.start_default()
#		connection_string = sitl.connection_string()
        vehicle = connect('127.0.0.1:14551', wait_ready=True)
#        vehicle = connect('/dev/ttyTHS2', wait_ready=True, baud=921600)
#	vehicle = connect(connection_string,wait_ready=True)

        return vehicle

def arm_and_takeoff(targetHeight):
	#while vehicle.is_armable!=True:
	#	print("Waiting for vehicle to become armable.")
	#	time.sleep(1)
	#print("Vehicle is now armable")

	#vehicle.mode = VehicleMode("GUIDED")

	while vehicle.mode!='GUIDED':
		print("Waiting for drone to enter GUIDED flight mode")
		# time.sleep(1)
	print("Vehicle now in GUIDED MODE. Have fun!!")

	#vehicle.armed = True
	while vehicle.armed==False:
		print("Waiting for vehicle to become armed.")
		time.sleep(1)
	print("Look out! Virtual props are spinning!!")

	#vehicle.simple_takeoff(targetHeight) ##meters

	#while True:
	#	print("Current Altitude: %d"%vehicle.location.global_relative_frame.alt)
	#	if vehicle.location.global_relative_frame.alt>=.95*targetHeight:
	#		break
	#	time.sleep(1)
	#print("Target altitude reached!!")

	return None

##Send a velocity command with +x being the heading of the drone.
def send_local_ned_velocity(vx, vy, vz):
	msg = vehicle.message_factory.set_position_target_local_ned_encode(
		0,
		0, 0,
		mavutil.mavlink.MAV_FRAME_BODY_OFFSET_NED,
		0b0000111111000111,
		0, 0, 0,
		vx, vy, vz,
		0, 0, 0,
		0, 0)
	vehicle.send_mavlink(msg)
	vehicle.flush()

##Send a velocity command with +x being the heading of the drone.
def send_global_ned_velocity(vx, vy, vz):
	msg = vehicle.message_factory.set_position_target_local_ned_encode(
		0, # time_boot_ms (not used)
		0, 0, # target system, target component
		mavutil.mavlink.MAV_FRAME_LOCAL_NED, #frame
		0b0000111111000111, #type_mask (only speeds enabled)
		0, 0, 0, # x, y, z positions (not used)
		vx, vy, vz, # x, y, z velocity in m/s
		0, 0, 0, #x, y, z acceleration (not supported yet, ignored in GCS_Mavlink)
		0, 0) #yaw, yaw_rate (not supported yet, ignored in GCS_Mavlink)
	vehicle.send_mavlink(msg)
	vehicle.flush()

##########MAIN EXECUTABLE###########
# Create a TCP/IP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Connect the socket to the port where the server is listening
server_address = ('localhost', 10000)
print('connecting to {} port {}'.format(*server_address))
sock.settimeout(10.0)
# sock = socket.create_connection(server_address, timeout=1000)
time.sleep(10)
sock.connect(server_address)
# sock.setdefaulttimeout(None)

# # Send data
# message = b'TCP client connected.'
# print('sending {!r}'.format(message))
# sock.sendall(message)

vehicle = connectMyCopter()
arm_and_takeoff(0.5)
time.sleep(2)

# write log file
log_gname='BoTest%s.txt' % (time.time())
gf = open(log_gname, mode='w')
gf.write("Guided velocity mode log DATA %s\n"%str(time.localtime()))
gf.write("time\t \gain\t err\t vel_set\t roll\t pitch\n") #coeffx\t coeffy\t
gf.close

# Controller parameters
gain = 0.0001

try:

    while True:
        sock.sendall(b'Next data.')

        data = sock.recv(2)
        print('received: ' + str(int.from_bytes(data,"big")))
        center_error = int.from_bytes(data,"big") - 320
        print('center_error = ', str(center_error))
        # if center_error > 15:
        vel_setpoint = -center_error * gain
        if vel_setpoint < -0.1:
            vel_setpoint = -0.1
        elif vel_setpoint > 0.1:
            vel_setpoint = 0.1
        elif abs(vel_setpoint) < 0.03:
            vel_setpoint = 0 
        
        if vel_setpoint != 0:
          send_local_ned_velocity(0,vel_setpoint,0)
          print("Moving left(-)/right(+), vel_set = " + str(vel_setpoint))
        elif vel_setpoint == 0:
          send_local_ned_velocity(0,0,-0.03)
          print("Drone is moving up.")
        # write log file
        roll_origin = vehicle.attitude.roll
        pitch_origin = vehicle.attitude.pitch 
        gf = open(log_gname, mode='a')
        gf.write("%s\t%f\t%f\t%f\t%f\t%f\n"%(datetime.datetime.now(),gain,center_error,vel_setpoint,roll_origin,pitch_origin))
        gf.close()
finally:
    print('closing socket')
    sock.close


# counter=0
# while counter<2:
# 	send_local_ned_velocity(0.2,0,0)
# 	time.sleep(1)
# 	print("Moving Forward to front of drone")
# 	counter=counter+1
# 
# time.sleep(2)

# counter=0
# while counter<2:
# 	send_local_ned_velocity(0,-0.2,0)
# 	time.sleep(1)
# 	print("Moving Left to front of drone")
# 	counter=counter+1

# counter=0
# while counter<2:
# 	send_local_ned_velocity(-0.2,0,0)
# 	time.sleep(1)
# 	print("Moving Back to front of drone")
# 	counter=counter+1
# 
# time.sleep(2)

# counter=0
# while counter<2:
# 	send_local_ned_velocity(0,0.2,0)
# 	time.sleep(1)
# 	print("Moving Right to front of drone")
# 	counter=counter+1

# time.sleep(2)

# while counter<2:
# 	send_global_ned_velocity(5,0,0)
# 	time.sleep(1)
# 	print("Moving TRUE NORTH relative to front of drone")
# 	counter=counter+1
#
# time.sleep(2)
#
# #counter=0
# while counter<2:
# 	send_global_ned_velocity(0,-5,0)
# 	time.sleep(1)
# 	print("Moving TRUE WEST relative to front of drone")
# 	counter=counter+1

#########UP AND DOWN############
# time.sleep(2)

#counter=0
# while counter<5:
# 	send_local_ned_velocity(0,0,-5)
# 	time.sleep(1)
# 	print("Moving UP")
# 	counter=counter+1
#
# time.sleep(2)

#counter=0
# while counter<5:
# 	send_local_ned_velocity(0,0,5)
# 	time.sleep(1)
# 	print("Moving DOWN")
# 	counter=counter+1
