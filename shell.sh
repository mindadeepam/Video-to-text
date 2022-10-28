# #!/bin/bash

# # install homebrew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# # add brew to path
# # export BREW_HOME="/home/linuxbrew/.linuxbrew/bin"
# # export PATH="$PATH:$BREW_HOME"
# test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
# test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bash_profile
# echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.profile

# #install wget
# echo -e "\n\n installing wget"
# brew install wget
# echo -e "\n\n installed wget"

# # install python specific version (3.6.4)
# echo -e "\n\n installing python"
# # chmod u+x install_python.sh
# # apt install make gcc zlib1g-dev libffi-dev
# # ./install_python.sh 3.6.
# sudo apt-get install python3.6
# echo -e "\n\n python installed"

# # install whisper
# echo -e "\n\n installing whisper"
# pip install git+https://github.com/openai/whisper.git
# echo -e "\n\nwhisper cloned"
# echo -e "\n\n installed whisper"

# # install ffmpeg
# echo -e "\n\n installing ffmpeg"
# brew install ffmpeg
# echo -e "\n\n installed ffmpeg"


# filepath=""
# outputdir="./"

# print_usage() {
#   printf "Usage: ..."
# }

# while getopts 'f:o:d:' flag; do
#     case "${flag}" in
#     o) outputdir="${OPTARG}";;
#     f) filepath="${OPTARG}";;
#     d) downloaddir="${OPTARG}";;
#     *) print_usage 
#         ;;
#     esac
# done

# echo -e "\nrunning main.py..."

# # python main.py \
# #   --filepath=${filepath} \
# #   --outputdir=${outputdir} \
  
  
  
  
