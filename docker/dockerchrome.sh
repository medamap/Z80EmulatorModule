#!/bin/bash

PROFILE_DIR="/home/develop/.config/google-chrome/Default"
mkdir -p "$PROFILE_DIR"

# DBus の起動
if [ ! -S /run/dbus/system_bus_socket ]; then
    echo "[INFO] Starting DBus..."
    /etc/init.d/dbus start
fi

# Chrome のプロファイルロックを解除
echo "[INFO] Removing Chrome profile lock files..."
rm -rf "$PROFILE_DIR/SingletonLock"
rm -rf "$PROFILE_DIR/SingletonSocket"

# GPU の有無を環境変数で判定
if [ -n "$USE_GPU" ]; then
    echo "[INFO] Starting Chrome in GPU mode..."
    google-chrome \
      --no-sandbox \
      --disable-dev-shm-usage \
      --disable-gpu-driver-bug-workarounds \
      --use-gl=egl \
      --no-default-browser-check \
      --user-data-dir="$PROFILE_DIR" \
      "$@" &
else
    echo "[INFO] Starting Chrome in CPU mode..."
    google-chrome \
      --no-sandbox \
      --disable-gpu \
      --disable-dev-shm-usage \
      --no-default-browser-check \
      --user-data-dir="$PROFILE_DIR" \
      "$@" &
fi
