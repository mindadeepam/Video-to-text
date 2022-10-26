#!/bin/bash

# install homebrew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# add brew to path
# export BREW_HOME="/home/linuxbrew/.linuxbrew/bin"
# export PATH="$PATH:$BREW_HOME"
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bash_profile
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.profile

#install wget
brew install wget

# install python specific version (3.6.4)
chmod u+x install_python.sh
apt install make gcc zlib1g-dev libffi-dev
./install_python.sh 3.6.4


# install whisper
pip install git+https://github.com/openai/whisper.git
echo -e "\n\nwhisper cloned"

# install ffmpeg
brew install ffmpeg


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

python main.py \
  --filepath=${filepath} \
  --outputdir=${outputdir} \
