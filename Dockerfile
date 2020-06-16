
# chat-space作成環境
# .macOs catalina
# .ruby 2.5.1
# .rails 5.2.4.3
# .mysql 5.6.47

# ベースとなるDocker Image を指定します。プロジェクトのrubyバージョンに合わせる。
# DockerはベースとなるDocker Image の上に COPY や RUN のようなコマンドを重ねてDocker Image を作成します。
# ベースとなるDocker Image は公式で提供されているImageを使用するのが一般的です。
FROM ruby:2.5.1

# ベースイメージに必要なパッケージのインストール（apt-getはlinuxのパッケージ管理ツールAPTのコマンド、macで言うhomebrew）
# apt-get update: パッケージをインストールするのに必要なインデックスファイルをダウンロードする。
# apt-get install: 後ろに続いて記載されたパッケージ達をインストールする
# nodejsとmysqlのクライアントを最小単位でインストール
# ファイルサイズの大きいパッケージリストのキャッシュを削除してimageのサイズを縮小
RUN apt-get update && \
    apt-get install -y nodejs --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*
RUN apt-get update && \
    apt-get install -y mysql-client --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# RUN apt-get update && \
#     apt-get install -y postgresql-client --no-install-recommends && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

# build-essential: 開発ツールのパッケージ
# libpq はPostgreSQLデータベースサーバにアクセスするためのC言語のライブラリ
# PHP,Ruby,Perl,Python,NodeJS,etcはlibpqを利用してPostgreSQLにアクセスするAPIを提供しています。
# -qq オプションはエラー以外の履歴を表示させない
# -y オプションはy/nの問い全てに自動的でyesと答える
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs

# 作業ディレクトリの作成（Dockerfileで新しく作成するimageファイル）                   
RUN mkdirRUN mkdirRUN mkdir /app_name

# 新しく作成するimageの環境変数に/app_nameのパスを設定する
ENV APP_ROOT /app＿name

# 上で作ったパスを使って作業ディレクトリ（この後に続くコマンドの実行ディレクトリ）を指定
WORKDIR $APP_ROOT

# オリジナルのGemfileをimageにコピー
ADD Gemfile $APP_ROOT/Gemfile
ADD Gemfile.lock $APP_ROOT/Gemfile.lock

# 上でコピーしたGemfileを元にbundle install
RUN bundle install
# カレントディレクトリをimageにコピー
ADD . $APP_ROOT