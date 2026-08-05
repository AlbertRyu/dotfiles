#!/bin/bash
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin"

if ! nc -z -G 5 u645441.your-storagebox.de 23 2>/dev/null; then
    echo "[$(date '+%F %T')] Storage Box 不可达，跳过"
    exit 0
fi

exec caffeinate -i borgmatic --verbosity 1
