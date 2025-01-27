# 学習意欲に基づく授業アンケートの分析

## 概要

このプロジェクトは 3 つの質問から学習意欲を推定することで、授業アンケートの結果を学習意欲別に分類することを目的としています。

---

フロントエンド: Flutter, graphic, riverpot
バックエンド: Python, FastAPI, NumPy, scikit-learn, pandas
インフラ: Docker

---

## 現在の進捗状況

- フロントエンド
  - 基本的な状態管理を行うシステムが完成
  - http 通信によるファイルの送受信が完成
  - ファイルのアップロードやアンケートの表示内容を選ぶための UI が完成
- バックエンド
  - 主成分分析を用いた学習意欲推定システムが完成
  - FastAPI を用いたファイルの送受信が完成
- インフラ
  - Docker を用いた環境構築が完了
    - フロントエンド、バックエンド、データベースのコンテナ化に成功

## 未完成部分

- フロントエンド
  - グラフの表示機能
  - レスポンシブ対応
- バックエンド
  - フロントエンド開発時に変更した API 通信の適用

---

## 今後の予定

1. フロントエンドのグラフの表示、レスポンシブ対応: 2025 年 3 月上旬までに実装予定
2. バックエンドの改良およびフロントエンドとの通信確認: 2025 年 3 月中旬に実装予定
3. 大学内ネットワークでのテスト: 2025 年 3 月~4 月上旬に実施予定

---

今後の課題
このシステムは、授業アンケートをより効果的に利用するための新たなアプローチを提供します。今後は、実際の授業での実証実験をもとに、システムの改良を行う予定です。
