# ベースイメージとしてPython 3.9を使用
FROM python:3.9

# 作業ディレクトリを作成
WORKDIR /server

# 依存関係のリストをコンテナにコピー
COPY requirements.txt .

# 依存関係をインストール
RUN pip install --no-cache-dir -r requirements.txt

# アプリケーションのソースコードをコンテナにコピー
COPY ./app/main.py .

# FastAPIアプリケーションをuvicornで実行
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
