#!/bin/bash

# See https://wiki.ubuntu.com/X/InputCoordinateTransformation
# For information on how the coordinate transformation matrix works.
# In short, it's a 3x3 matrix thats multiplied by a vector matrix of
# the pointer position.
#
# |1 0 0|   |x|   |x|
# |0 1 0| . |y| = |y|
# |0 0 1|   |1|   |1|
mouseId=`xinput | grep -o "Logitech Gaming Mouse.*" | sed -E "s/.*id=([0-9]+).*/\1/"`
mouseSensXform=1 # > 1 slows, < 1 accels
xinput --set-prop ${mouseId} 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 ${mouseSensXform}

# Some people say that libinput Accel Speed is the better prop to modify.
# See: https://github.com/WayfireWM/wayfire/issues/192
mouseSensAccel=-0.55 # < 0 slows, > 0 accels
xinput --set-prop ${mouseId} 'libinput Accel Speed' ${mouseSensAccel}

