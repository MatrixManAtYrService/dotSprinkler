#!/usr/bin/env bash

wget -P "$CONFIG_DIR/_vim/bundle" https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/conque/conque_2.3.tar.gz
tar xvf "$CONFIG_DIR/_vim/bundle/conque_2.3.tar.gz" -C "$CONFIG_DIR/_vim/bundle/"
rm "$CONFIG_DIR/_vim/bundle/conque_2.3.tar.gz"
echo "*" > "$CONFIG_DIR/_vim/bundle/conque_2.3/.gitignore"
