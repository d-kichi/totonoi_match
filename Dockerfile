FROM ruby:3.2.2

# 必要パッケージ
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

WORKDIR /app

# Gemfileをコピー
COPY Gemfile Gemfile.lock ./

# bundlerをインストールしてからbundle install
RUN gem install bundler && bundle install

# ソースをコピー
COPY . .

# PATH設定（railsコマンド用）
ENV PATH="/usr/local/bundle/bin:${PATH}"

# サーバー起動コマンド
CMD ["rails", "server", "-b", "0.0.0.0"]
