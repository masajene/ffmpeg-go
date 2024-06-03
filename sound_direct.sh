#!/bin/bash

# 引数のチェック
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <file_name> <volume>"
    exit 1
fi

file_name=$1
volume=$2

# 数字に対応する音声ファイルのディレクトリ
sound_dir="sound_files"

sound_file="${sound_dir}/${file_name}.mp3"

# 再生（Linuxのサウンドツールを使用）
#play $sound_file

