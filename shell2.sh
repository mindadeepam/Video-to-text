#!/bin/bash

sudo apt-get update
sudo apt install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install python3.8

echo -e "\n\ninstalling python 3"
# sudo apt-get install python -y
if [ $(dpkg-query -W -f='${Status}' python3.6 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  sudo apt-get install python3 -y;
fi

echo -e "\n\npython installed/n"

echo -e "\n\ninstalling ffmpeg/n"
sudo apt-get install ffmpeg -y
echo -e "\n\nffmpeg installed/n"

echo -e "\n\ninstalling wget/n"
sudo apt-get install wget -y
echo -e "\n\nwget installed/n"

# install whisper
echo -e "\n\ninstalling whisper"
pip install git+https://github.com/openai/whisper.git
echo -e "\n\nwhisper installed"


filepath=""
outputdir="./"

print_usage() {
  printf "Usage: ..."
}

while getopts 'f:o:' flag; do
    case "${flag}" in
    f) filepath="${OPTARG}";;
    o) outputdir="${OPTARG}";;
    *) print_usage 
        ;;
    esac
done

echo -e "\nrunning main.py..."

python3 main.py \
  --filepath=${filepath} \
  --outputdir=${outputdir} \
  
  
  
  


