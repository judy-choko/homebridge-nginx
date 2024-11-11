# Node.js 22.10.0をベースイメージとして使用
FROM node:22.10.0

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y nginx apache2-utils

# Homebridgeとプラグインのインストール
RUN npm install -g --unsafe-perm homebridge homebridge-config-ui-x @switchbot/homebridge-switchbot

# Nginx設定ファイルのコピー
COPY nginx.conf /etc/nginx/nginx.conf

# 環境変数で指定されたユーザー名とパスワードでBasic認証ファイルを作成
RUN echo "#!/bin/bash" > /generate_htpasswd.sh \
    && echo "htpasswd -bc /etc/nginx/.htpasswd \$BASIC_AUTH_USERNAME \$BASIC_AUTH_PASSWORD" >> /generate_htpasswd.sh \
    && chmod +x /generate_htpasswd.sh

# ポートの公開
EXPOSE 80 8581

# 起動スクリプトのコピー
COPY start.sh /start.sh
RUN chmod +x /start.sh

# コンテナ起動時に実行するコマンド
CMD ["/start.sh"]
