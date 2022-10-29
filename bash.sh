#!/bin/bash

filepath=""
outputdir=""
downloaddir=""

print_usage() {
  printf "Usage: ..."
}

while getopts 'f:d:' flag; do
    case "${flag}" in
    f) filepath="${OPTARG}";;
    d) downloaddir="${OPTARG}";;
    *) print_usage 
        ;;
    esac
done

echo -e "\nrunning main.py..."
echo -e ${filepath} ${downloaddir} 

python3 main.py \
  --filepath=${filepath} \
  --downloaddir=${downloaddir} 
  # --outputdir=${outputdir} \

  
  
  
  


