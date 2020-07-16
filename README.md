# Avartus

ゲーム感覚で今日やったことの記録をつけることで、日々の成長に
喜びを感じられることを意識して作ったアプリです。   

## サイトURL
https://avartus0703.herokuapp.com/

## 主な機能

- ユーザーのCRUD機能
- ログイン機能
- パラメータ管理機能(jQery Raty)
- ユーザー一覧の並べ替え機能
- 画像アップロード機能(carrierwave, mini_magick, fog)

## 環境

- 言語(Ruby 2.4.0)
- フレームワーク(Rails 5.1.7) 

## 使用技術
- 言語/フレームワーク
    - Ruby2.4.0 / Ruby on Rails 5.1.7
- 開発環境
    - Vagrant(CentOS7)
    - Visual Studio Code
- 本番環境
    - heroku
- 使用技術
    - CircleCI
    - GitHub
    - AWS
        - S3
    - GCP
        - Geocoding API
        - Maps JavaScript API
- DB
    - PostgreSQL
- デザイン
    - Bootstrap
- ページネーション
    - kaminari
- コード整形
    - Rubocop
- テスト
    - Minitest

## 今後の課題
・herokuからAWSを使ったデプロイに切り替える。
・チーム開発を意識(ブランチ、issue)。
・awsやdockerの導入
