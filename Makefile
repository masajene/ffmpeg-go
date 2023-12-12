# ビルドするアプリケーションの名前を設定
APP_NAME=app

# ビルド対象のOSとアーキテクチャを設定
GOOS=linux
GOARCH=amd64

# ビルドのコマンド
build:
	GOOS=$(GOOS) GOARCH=$(GOARCH) go build -o $(APP_NAME)

# クリーンアップのコマンド
clean:
	rm -f $(APP_NAME)

.PHONY: build clean
