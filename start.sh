#!/bin/bash
# 環境変数からBasic認証ファイルを生成
/generate_htpasswd.sh

# Homebridgeをバックグラウンドで起動
homebridge -I &

# Nginxをフォアグラウンドで起動
nginx -g 'daemon off;'
