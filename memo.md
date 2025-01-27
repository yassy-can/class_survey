最低限の動作
client

- homepage 学習意欲に基づき、5 点尺度と自由記述を分類して表示、アンケートデータを保持しているかどうかを確かめ、filepicker に遷移
  - filepicker ローカルの csv ファイルをピックアップし、api でサーバーにデータを送信 & データを保持して表示
    - rename 科目名を決定（初期値　ファイル名）
    - selectquestion どの項目を表示するか選ぶ

server

- db からアンケートの元データを取得し、python で分析を行う
- 分析結果を送信

db

- 初期状態でアンケートのサンプルを保存

20241105 client の apiGet メソッドの実装まで。未確認。
pickfile でファイルの読み込み
20241113 client の display の実装と ui 構築
20241127 Api でファイルの送信、中身の確認まで
20241204 Api でファイルを受け取り、処理をして結果を送信

flutter pub run build_runner build --delete-conflicting-outputs

20250116 　これまで useQuestion を更新した後画面遷移できていたが、できなくなったのでこれから goruter に切り替える やっぱなし
