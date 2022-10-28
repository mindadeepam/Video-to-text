
import whisper
import os
import subprocess
import sys
import pickle
import argparse
import time
import pandas as pd
from whisper.utils import write_srt, write_vtt

print("\nloading model... ")
begin = time.time()
model = whisper.load_model("small")
print("model loaded ")
end = time.time()
print(f"time taken to load model = {end-begin:.2f} seconds")

def runcmd(cmd, verbose = False, *args, **kwargs):

    process = subprocess.Popen(
        cmd,
        stdout = subprocess.PIPE,
        stderr = subprocess.PIPE,
        text = True,
        shell = True
    )
    std_out, std_err = process.communicate()
    if verbose:
        print(std_out.strip(), std_err)
    return

def get_duration(input_videopath):
    cmd = f"ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 {input_videopath}"
    p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr = subprocess.PIPE, text = True, shell = True)
    out, err = p.communicate()
    return out

def video2mp3(video_filepath, output_ext="mp3"):
    # print(video_file)
    # print(f"video path = {video_filepath}" )
    video_file = video_filepath[:-4]
    filename, ext = os.path.splitext(video_filepath)
    # video_filename = video_filepath.split("/")[-1].split(".")[0]
    # print(filename, ext)
    audio_path = f"{video_file}.{output_ext}"
    # print(f"audio path  = {audio_path}" )
    subprocess.call(["ffmpeg", "-y", "-i", video_filepath, audio_path], 
                    stdout=subprocess.DEVNULL,
                    stderr=subprocess.STDOUT)
    return audio_path

def translate(q_id, video_url, download_dir=None, task="translate", language='en', vid_extension = '.mp4'):

    # download video
    if(not os.path.exists(download_dir)):
        download_dir = "./download/"
        runcmd(f"mkdir {download_dir}")

    video_name = str(q_id) + vid_extension
    input_videopath = os.path.join(download_dir, video_name)  
    runcmd(f"wget -O {input_videopath} {video_url}")
     
    # extract audio from video
    audio_path = video2mp3(input_videopath)
    
    # transcribe text from audio 
    options = dict(beam_size=5, best_of=5, language=language, fp16=False)
    translate_options = dict(task=task, **options)

    dur = get_duration(input_videopath)
    print(f"\nvideo duration : {int(float(dur))} seconds")

    print(f"transcribing {input_videopath}..")
    begin = time.time()
    result = model.transcribe(audio_path,**translate_options)
    end = time.time()
    print(f"time taken to transcribe video = {end-begin:.2f} seconds\n")
    # make srt file in download directory
    # if not os.path.exists(download_dir):
    #     output_dir = "./subtitles/"
    #     runcmd(f"mkdir {output_dir}")
        

    audio_file = audio_path.split(".")[0]
    audio_filename = audio_path.split("/")[-1].split(".")[0]
    srt_path = os.path.join(download_dir, audio_filename + ".srt")
    with open(srt_path, "w", encoding="utf-8") as srt:
        write_srt(result["segments"], file=srt)
    
    
    # delete audio and video files
    if os.path.exists(input_videopath):
        runcmd(f"rm {input_videopath}")
    if os.path.exists(audio_path):
        runcmd(f"rm {audio_path}")
    
    # subtitle = audio_path + ".vtt"
    # output_video = audio_path + "_subtitled.mp4"

    # os.system(f"ffmpeg -i {input_video} -vf subtitles={subtitle} {output_video}")

    # return output_video
    return srt_path



def main(params):
    input_csv = params.filepath
    # output_dir = params.outputdir
    download_dir = params.downloaddir
    # print(f"input csv file path : {input_csv} \ndownload directory : {download_dir}")

    # check if input csv filepath is valid
    while not os.path.exists(input_csv) or input_csv[-3:]!='csv':
        if not os.path.exists(input_csv):
            print("input file doesnt exist.")
        elif input_csv[-3:]!='csv':
            print("input file is not a csv file. Enter a csv file path")
        input_csv = input()

    # read csv    
    input_csv = pd.read_csv(input_csv)

    if input_csv.index.name == "q_id": 
        input_csv = input_csv.reset_index()
    
    # output csv initialize
    df = pd.DataFrame(columns=["q_id", "srtfilepath"])
    df.astype({"q_id":'str', "srtfilepath":'str'})
    df = df.set_index("q_id")

    # for each row, generate srt file and add its path in output csv
    for _, row in input_csv.iterrows():
        srt_path = translate(row['q_id'], row['url'], download_dir=download_dir)
        df.loc[row["q_id"]] =  os.path.abspath(srt_path)
        if _>3:break

    # save output csv
    output_path = "./srt_table.csv"
    df.to_csv(f"{output_path}")
    print(f"output csv file saved as {output_path}")

    return 



if __name__=='__main__':
    parser = argparse.ArgumentParser(description='use whisper to generate srt files for given video files')

    parser.add_argument('-f', '--filepath', help='path of input csv file (q_id, video_link)')
    # parser.add_argument('-d', '--downloaddir', help="download directory for srt files, video and audio files are also downloaded here temporarily")
    parser.add_argument('-o','--outputdir', help='output directory for srt files')
    args = parser.parse_args()
    main(args)