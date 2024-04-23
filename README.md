# hello-ros2-docker

This repository provides a boilerplate for running ROS2 in a Docker container, eliminating the need for multiple package installations on the host machine. To facilitate the development process, necessary files and directories are located on the host machine and shared with the container.

# Quickstart

```
# In the terminal of the host machine
$ git clone https://github.com/lee-zion/hello-ros2-docker.git
$ cd hello-ros2-docker
$ docker build --build-arg UID=$(id -u) --build-arg GID=$(id -g) -t IMAGE_NAME .
```

- Install Dev Containers extension by Microsoft in VS Code
- Open the command palette (Ctrl+Shift+P)
- Select Dev Containers: Open Folder in Container...
- Select the root folder of this project
- Select From 'docker-compose.yml' in the dropdown
- Select nothing from additional features

```
# In the terminal of the container
 humble@edcb33e24845  /workspaces/minimal_publisher   main  cc
 humble@edcb33e24845  /workspaces/minimal_publisher   main  cb
Starting >>> examples_rclpy_minimal_publisher
Finished <<< examples_rclpy_minimal_publisher [0.95s]          

Summary: 1 package finished [1.66s]
 humble@edcb33e24845  /workspaces/minimal_publisher   main  sc
 humble@edcb33e24845  /workspaces/minimal_publisher   main  ros2 run examples_rclpy_minimal_publisher publisher_member_function
[INFO] [1713852419.824201675] [minimal_publisher]: Publishing: "Customized Hello World: 0"
[INFO] [1713852420.315478498] [minimal_publisher]: Publishing: "Customized Hello World: 1"
[INFO] [1713852420.815507802] [minimal_publisher]: Publishing: "Customized Hello World: 2"
```

# Build Docker Image

- Execute the command below from the root directory of the repository

```zsh
$ docker build --build-arg UID=$(id -u) --build-arg GID=$(id -g) -t IMAGE_NAME .
```

This Dockerfile starts with the humble image from OSRF and adds a user for development to ensure security and file/directory permissions. Additionally, common alias commands for ROS2 and zsh have been installed for convenience.

# Using VS Code Dev Container
To further streamline the development process, you can use the Dev Container feature of Visual Studio Code. Here are the steps:

1. Install the Dev Containers extension by Microsoft in Visual Studio Code.
2. Open the command palette and run the Remote-Containers: Open Folder in Container... command.
3. Select the root folder of your project (the folder that contains your docker-compose.yml file).
4. In the Select the definition you want to create dropdown, select From 'docker-compose.yml'.
5. In the Select the service you want to use dropdown, choose as per your requirement.
6. In the Select additional features to install, choose as you desire (you can install zsh in this stage)

Now, both directories are synchronized, both host and container can make changes, and both are applied immediately.

# Running ROS2 Commands
After entering the terminal of the container, you can use ROS2 features with aliases like cb to build with colcon from the current directory.

```
 humble@edcb33e24845  /workspaces/minimal_publisher   main  cc
 humble@edcb33e24845  /workspaces/minimal_publisher   main  cb
Starting >>> examples_rclpy_minimal_publisher
Finished <<< examples_rclpy_minimal_publisher [0.95s]          

Summary: 1 package finished [1.66s]
 humble@edcb33e24845  /workspaces/minimal_publisher   main  sc
 humble@edcb33e24845  /workspaces/minimal_publisher   main  ros2 run examples_rclpy_minimal_publisher publisher_member_function
[INFO] [1713852419.824201675] [minimal_publisher]: Publishing: "Customized Hello World: 0"
[INFO] [1713852420.315478498] [minimal_publisher]: Publishing: "Customized Hello World: 1"
[INFO] [1713852420.815507802] [minimal_publisher]: Publishing: "Customized Hello World: 2"
```

# Running Multiple Containers
You can also run multiple containers simultaneously using docker-compose.yml file. Here's a minimal example:

```
services:
  talker:
    image: osrf/ros:humble-desktop-full-jammy
    command: ros2 run demo_nodes_cpp talker
  listener:
    image: osrf/ros:humble-desktop-full-jammy
    command: ros2 run demo_nodes_cpp listener
    depends_on:
      - talker
```

To run the containers, execute docker-compose up in the same directory. You can stop the containers by pressing Ctrl+C.

# Reference

- [ROS in Docker of WSL2](https://ropiens.tistory.com/161)
- [File permission in Linux](https://sweethoneybee.tistory.com/28) and [Docker](https://medium.com/@mccode/understanding-how-uid-and-gid-work-in-docker-containers-c37a01d01cf)
- [ROS2 argcomplete](https://github.com/ros2/ros2cli/issues/534#issuecomment-1193010819)