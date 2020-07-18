# imager

## これは何？

rugamaga.netで動いている画像記録用アプリ(imager)のリポジトリです。
database, frontend, backendの3つのマイクロサービスで構成されています。

## 使い方

### 初回セットアップ

#### 1. rugamaga.netを構築しておく

https://github.com/rugamaga/rugamaga-terraform を利用して
rugamaga.net/rugamaga.devを作成しましょう。
このとき、このアプリのためのサブドメインを切っておいてください。

#### 2. 各種service accountを発行しキーを保存する

ルートプロジェクトで、GCRアクセス用のサービスアカウントを発行しましょう。

- ROOT環境: `.credentials/repository@rugamaga.json`

として記録します。
このサービスアカウントに対してはGCSのストレージ管理者権限を付与します。

またGKEへのマニフェストをapplyできるサービスアカウントを発行しましょう。
取り扱えるだけの権限をもったservice accountを各環境で発行して
それらのJSONキーをそれぞれ

- PRD環境: `.credentials/kubernetes@rugamaga-prd.json`
- DEV環境: `.credentials/kubernetes@rugamaga-dev.json`

として記録します。
またこれらのサービスアカウントに対してはGCSのバケット読み取り権限を付与します。

#### 3. CircleCIセットアップ

CircleCIの環境変数を設定します。

- `REPO_GCLOUD_SERVICE_KEY`: `.credentials/repository@rugamaga.json` の中身をすべて貼り付ける
- `PRD_GCLOUD_SERVICE_KEY`: `.credentials/kubernetes@rugamaga-prd.json` の中身をすべて貼り付ける
- `DEV_GCLOUD_SERVICE_KEY`: `.credentials/kubernetes@rugamaga-dev.json` の中身をすべて貼り付ける
- `PRD_IMAGER_DATABASE_PASSWORD`: ランダムなパスワードを決めて設定する。PRD用のDBパスワードになる。
- `DEV_IMAGER_DATABASE_PASSWORD`: ランダムなパスワードを決めて設定する。DEV用のDBパスワードになる。

環境を増やす場合はそれに従った環境変数を増やします。

### CircleCI

#### コンテナビルドする

git pushを行うたびに自動的に行われます。

#### Planする

Planはgit pushを行うたびに自動的に行われます。

#### Releaseする

masterブランチが進むと自動的にDEV環境が更新されます。

PRD環境へのリリースは `PRD/vN.N.N` というタグを張ってください。
vN.N.Nは通常のセマンティックバージョニングに従ってください。

一般にXXX環境へのリリースは `XXX/vN.N.N` というタグを増やす形で行いましょう。
