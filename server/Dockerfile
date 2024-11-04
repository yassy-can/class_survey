# ベースイメージとしてPython 3.9を使用
FROM python:3-alpine

# 作業ディレクトリを作成
WORKDIR /server

# 依存関係のリストをコンテナにコピー
COPY requirements.txt .

# 依存関係をインストール
#RUN pip install --no-cache-dir -r requirements.txt

RUN apk update \
&& apk add postgresql-libs \
&& apk add --virtual .build-deps gcc musl-dev postgresql-dev \
&& apk add --no-cache build-base \
&& python3 -m pip install -r requirements.txt --no-cache-dir

# アプリケーションのソースコードをコンテナにコピー
COPY ./app server/app

# FastAPIアプリケーションをuvicornで実行
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]


#memo: 20241101 これまで起動できたserverがうまく立ち上がらない
