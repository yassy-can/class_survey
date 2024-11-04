# Ubuntuベースのイメージ
FROM ubuntu:20.04

# 環境変数と非対話モードの設定
ENV DEBIAN_FRONTEND=noninteractive

# 必要なパッケージのインストール
RUN apt-get update && \
    apt-get install -y curl git wget unzip libglu1-mesa fonts-droid-fallback && \
    apt-get clean

# Flutter SDKのダウンロードと設定
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Flutterパスを設定
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# FlutterのWebサポートを有効化し、安定版を使用
RUN flutter channel stable && \
    flutter upgrade && \
    flutter config --enable-web

RUN ls
# アプリケーションのソースコードをコンテナにコピー
COPY . client

WORKDIR /client


# Webビルドの実行
#RUN flutter build web

# ポート公開とビルドされたアプリの提供
EXPOSE 9000

# Webサーバーでアプリケーションを提供
# CMD ["flutter", "run", "-d", "web-server", "--web-port", "9000", "--release", "--web-hostname", "0.0.0.0"]
CMD ["flutter", "run", "-d", "web-server", "--web-port", "9000", "--web-hostname", "0.0.0.0"]