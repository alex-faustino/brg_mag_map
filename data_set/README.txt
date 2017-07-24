MagPIE is a dataset for the evaluation of indoor positioning using magnetic anomalies. 
Such anomalies have been used for mapping and localization of smartphones and robots indoors. 
Our dataset contains IMU and calibrated magnetometer measurements accompanied by accurate ground 
truth measurements. We collected sensor readings from two platforms: a smartphone and a ground robot. 
We provide data from three buildings on the University of Illinois at Urbana-Champaign campus. 
For each test case, we collect data in a setting that contains only dead loads-that is free of 
magnetic anomalies that are not inherent to the building-and a second set of data that contains 
live loads. Finally, we present a baseline approach for localizing within a surveyed map using our 
dataset.

By: David Hanley, Alexander B. Faustino, Scott D. Zelman, David A. Degenhardt, and Timothy Bretl

Please send bug reports to David Hanley at hanley6@illinois.edu

* - Moto Z frame
** - Tango frame wrt World frame
*** - Moto Z frame wrt World frame
--------------------------------------
Output_accel Format*
--------------------------------------
Time (s)	accelerometer_x (m/s^2)	accelerometer_y (m/s^2)	accelerometer_z (m/s^2)

--------------------------------------
Output_gyro Format*
--------------------------------------
Time (s)	gyro_x (rad/s)	gyro_y (rad/s)	gyro_z (rad/s)

--------------------------------------
Output_gt Format**
--------------------------------------
Time (s)	position_x (m)	position_y (m)	position_z (m) quat_x	quat_y	quat_z	quat_w

--------------------------------------
Output_mag Format*
--------------------------------------
Time (s)	magnetometer_x (muT)	magnetometer_y (muT)	magnetometer_z (muT)

--------------------------------------
Initial_DCM Format***
--------------------------------------

	C(1,1)	C(1,2)	C(1,3)
DCM =	C(2,1)	C(2,2)	C(2,3)
	C(3,1)	C(3,2)	C(3,3)

--------------------------------------
Moto Z Frame wrt Tango Frame
--------------------------------------

            1             0               0
R_Walking = 0 cos(25*pi/180) -sin(25*pi/180)
            0 sin(25*pi/180)  cos(25*pi/180)

        1  0  0
R_Ugv = 0  0  1
        0 -1  0
