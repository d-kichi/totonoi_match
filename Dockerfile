FROM ruby:3.2.2

# 必要パッケージ
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

WORKDIR /app

# Gemfile をコピー
COPY Gemfile Gemfile.lock ./

# bundler をインストールしてから bundle install
RUN gem install bundler && bundle install

# ソースをコピー
COPY . .

# PATH 設定（rails コマンド用）
ENV PATH="/usr/local/bundle/bin:${PATH}"

# 起動時にアセットをプリコンパイルしてからサーバー起動
ENTRYPOINT ["bash", "-c", "bundle exec rails assets:precompile && rails server -b 0.0.0.0"]
