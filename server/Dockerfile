# ベースイメージとしてPython 3.9を使用
FROM python:3-slim

# 作業ディレクトリを作成
WORKDIR /server

# 依存関係のリストをコンテナにコピー
COPY requirements.txt .

# 依存関係をインストール
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    libatlas-base-dev \
    gfortran \
	&& python3 -m pip install --upgrade pip \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install -r requirements.txt --no-cache-dir

# アプリケーションのソースコードをコンテナにコピー
COPY ./app app

# FastAPIアプリケーションをuvicornで実行
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]


#memo: 20241101 これまで起動できたserverがうまく立ち上がらない
