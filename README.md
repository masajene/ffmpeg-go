# Go FFPMEG合成ツール

## 概要
FFMPEGを使って動画を合成するツールです。
GoはシンプルなAPIサーバーになっており、リクエストされた文字列とボリューム設定をシェルに流します。

```
curl --location 'localhost:8080?number=1234&volume=100' \
--header 'Authorization: your_api_token'
```

## 環境変数
- API_TOKEN: APIのトークン
- PORT: APIのポート番号
- HTTPS_CERT_FILE: HTTPSの証明書ファイル
- HTTPS_KEY_FILE: HTTPSの秘密鍵ファイル
- SHELL_SCRIPT_PATH: シェルスクリプトのパス

## シェルの説明
- 受け取った数字文字列を分解し、結合元の音声ファイルを特定します。
- 結合元の音声ファイルは`sound_files`ディレクトリに格納しています。
- 結合された音声ファイルは`tmp/output.mp3`ディレクトリに格納されます。
- 再生は現在仮で `play` コマンドを使っています。(コメントアウト済み)