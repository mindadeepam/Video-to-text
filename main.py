
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
model = whisper.load_model("large")
print("model loaded ")
end = time.time()
print(f"time taken to load model = {end-begin:.2f} seconds")



def video2mp3(video_file, output_ext="mp3"):
    # print(video_file)
    filename, ext = os.path.splitext(video_file)
    # print(filename, ext)
    subprocess.call(["ffmpeg", "-y", "-i", video_file, f"{filename}.{output_ext}"], 
                    stdout=subprocess.DEVNULL,
                    stderr=subprocess.STDOUT)
    return f"{filename}.{output_ext}"

def translate(input_video, output_dir="./subtitles/",task="translate", language='en'):

    audio_path = video2mp3(input_video)
    print("audio path: ", audio_path)    
    options = dict(beam_size=5, best_of=5, language=language)
    translate_options = dict(task=task, **options)
    result = model.transcribe(audio_path,**translate_options)

    # # output_dir = '/content/'
    audio_file = audio_path.split(".")[0]
    audio_filename = audio_path.split("/")[-1].split(".")[0]
    srt_path = os.path.join(output_dir, audio_filename + ".srt")
    with open(os.path.join(output_dir, audio_filename + ".srt"), "w", encoding="utf-8") as srt:
        write_srt(result["segments"], file=srt)

    # subtitle = audio_path + ".vtt"
    # output_video = audio_path + "_subtitled.mp4"

    # os.system(f"ffmpeg -i {input_video} -vf subtitles={subtitle} {output_video}")

    # return output_video
    return 1


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
    pass




def main(params):
    input_csv = params.filepath
    output_dir = params.outputdir
    print(input_csv, "\n", output_dir)

    input_csv = pd.read_csv(input_csv)
   
    # print(input_csv)
    
    for _, row in input_csv.iterrows():
        srt_path = translate(row['filepath'], output_dir)
        # print(row["filepath"])
        break

    pass



if __name__=='__main__':
    parser = argparse.ArgumentParser(description='use whisper to generate srt files for given video files')

    parser.add_argument('-f', '--filepath', help='path of input csv file (q_id, video_link)')
    parser.add_argument('-o','--outputdir', help='output directory for srt files')
    args = parser.parse_args()
    main(args)