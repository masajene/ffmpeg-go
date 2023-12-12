#!/bin/bash

# 引数のチェック
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <number_string> <volume>"
    exit 1
fi

number_string=$1
volume=$2

# 数字に対応する音声ファイルのディレクトリ
sound_dir="sound_files"

# 一時的なファイル名
output_file="tmp/output.mp3"

# 一時ファイルを削除
rm -f $output_file

len=${#number_string}
for (( i=0; i<$len; i++ )); do
    digit=${number_string:$i:1}
    if [ "$digit" -eq 0 ]; then
        continue
    fi

    if [ $((len-1)) -eq $i ]; then
        zeros=""
    else
        zeros=$(printf '%0*d' $((len-i-1)) 0)
    fi

    sound_file="${sound_dir}/voice_${digit}${zeros}.mp3"
    if [ ! -f "$sound_file" ]; then
        echo "Sound file for 'voice_${digit}${zeros}' not found."
        continue
    fi

    if [ -f "$output_file" ]; then
        ffmpeg -hide_banner -loglevel error -i "$output_file" -i "$sound_file" -filter_complex '[0:0][1:0]concat=n=2:v=0:a=1[out]' -map '[out]' temp_output.mp3
        mv temp_output.mp3 $output_file
    else
        cp "$sound_file" "$output_file"
    fi
done

# 再生（Linuxのサウンドツールを使用）
#play $output_file

# 一時ファイルを削除
#rm -f $output_file
