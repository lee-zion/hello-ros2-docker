#!/bin/bash
cd ~
colcon build --symlink-install
source install/setup.bash
ros2 run examples_rclpy_minimal_publisher publisher_member_function