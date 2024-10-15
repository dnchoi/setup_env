sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

sudo apt update && sudo apt install -y curl gnupg2 lsb-release 
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'

sudo apt update
sudo apt install -y ros-foxy-desktop

source /opt/ros/foxy/setup.bash

echo 'source /opt/ros/foxy/setup.bash' >> ~/.zshrc

sudo apt install -y python3-pip
pip3 install -U argcomplete
sudo apt install -y python3-colcon-common-extensions

ros2 run demo_nodes_cpp talker

ros2 run demo_nodes_py listener
