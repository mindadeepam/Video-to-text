# Video-to-text

Generate subtitle files *(.srt)* for videos using <a href="https://github.com/openai/whisper">OpenAI's Whisper</a>

## System Requirements

    Python > 3.7
    ffmpeg
    wget
    bash
    git

## Setup
Install git using 
```bash
sudo apt-get install git -y
```

Clone repository using 
```bash
git clone https://github.com/mindadeepam/Video-to-text.git
```

Change directory into the repository base folder 
```bash
cd Video_to_text
```

To get started, run the *setup.sh* script. 
*It installs all system requirements and all required python libraries from requirements.txt.*
    
```bash
# on Ubuntu/Debian
chmod +x setup.sh
./setup.sh
```

## Approach

A python script takes as input a csv file, makes subtitle files for all videos using the csv table and returns a csv file containing filepaths to the downloaded srt files for each video. 

    Input : csv file
    Downloads : .srt files 
    Output : csv file

## Command-line usage

Run the python script using a bash script, *bash.sh*
```bash
chmod +x bash.sh
./bash.sh
```

Input to the python script should be a csv file containing columns **q_id** *(question id)* and **url** *(url link of video)*

| q_id | url    | 
| :---:   | :---: | 
| 1 | https://d3cvwyf9ksu0h5.cloudfront.net/answer-1554740957.mp4   |
| 2 | https://d3cvwyf9ksu0h5.cloudfront.net/answer-1556108746.mp4   |
| 3 | https://d3cvwyf9ksu0h5.cloudfront.net/QA/9519221/360p.mp4  |


By default, it will look for input.csv in the root directory. Specify path to input.csv using `-f <filepath>`
```bash    
./bash.sh -f ./input.csv 
```

By default the subtitle files are downloaded into `./downloads/` directory in the root folder. Adding `-d <download/dir/path/>` will download all subtitles in the specified directory. *(video and auido files are also temporarily downloaded here)*

```bash    
./bash.sh -d ./downloads/ 
```

The ouput csv is saved as `srt_table.csv` in the root directory.
| q_id | srtfilepath    | 
| :---:   | :---: | 
| 1 | ./downloads/1.srt   |
| 2 | ./downloads/2.srt |
| 3 | ./downloads/3.srt  |
