# !/bin/bash

apt-get update
# apt-get install -y sudo

echo -e "\n\ninstalling python 3.8"
apt install software-properties-common -y
add-apt-repository ppa:deadsnakes/ppa -y
# apt install -y python3.8 
# python3 -m ensurepip --upgrade
apt install -y python3-pip
echo -e "\npython installed\n"

echo -e "\n\ninstalling git"
apt-get install git -y
echo -e "\ngit installed\n"

echo -e "\n\ninstalling ffmpeg\n"
apt-get install ffmpeg -y
echo -e "\nffmpeg installed\n"

echo -e "\n\ninstalling wget\n"
apt-get install wget -y
echo -e "\nwget installed\n"

echo -e "\n\ninstalling whisper"
pip install git+https://github.com/openai/whisper.git
echo -e "\nwhisper installed"

echo -e "\n\ninstalling dependencies"
pip install -r requirements.txt
echo -e "\n\ndone...\n"