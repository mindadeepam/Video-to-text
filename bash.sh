#!/bin/bash



# echo -e "\n\ninstalling python 3.8"
# sudo apt-get update 
# sudo apt install software-properties-common
# sudo add-apt-repository ppa:deadsnakes/ppa
# sudo apt-get update
# sudo apt install python3.8 -y
# echo -e "\npython installed/n"

# echo -e "\n\ninstalling ffmpeg/n"
# sudo apt-get install ffmpeg -y
# echo -e "\nffmpeg installed/n"

# echo -e "\n\ninstalling wget/n"
# sudo apt-get install wget -y
# echo -e "\nwget installed/n"

# install whisper
# echo -e "\n\ninstalling whisper"
# pip install git+https://github.com/openai/whisper.git
# echo -e "\nwhisper installed"

# echo -e "\n\ninstalling dependencies"
# pip install -r requirements.txt
# echo -e "\n\ndone...\n"


filepath=""
outputdir=""
downloaddir=""

print_usage() {
  printf "Usage: ..."
}

while getopts 'f:o:d:' flag; do
    case "${flag}" in
    f) filepath="${OPTARG}";;
    # o) outputdir="${OPTARG}";;
    d) downloaddir="${OPTARG}";;
    *) print_usage 
        ;;
    esac
done

echo -e "\nrunning main.py..."

python3 main.py \
  --filepath=${filepath} \
  # --outputdir=${outputdir} \
  --downloaddir=${downloaddir}
  
  
  
  


