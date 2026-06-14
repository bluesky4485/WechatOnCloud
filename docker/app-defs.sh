# 应用定义（被 autostart 与 app-ctl.sh source）。给定应用类型，输出该应用的：
#   APP_BIN    — 可执行文件路径（autostart 据此判断"是否就绪/已安装"）
#   APP_LAUNCH — 启动命令（可带参数；autostart 以 word-split 方式执行，参数勿含空格）
#   APP_NAME   — 显示名（日志用）
# 缺省/未知类型一律回退微信，保证老实例零改动。v1.2.0 多应用平台。
woc_app_def() {
  case "${1:-wechat}" in
    telegram)
      APP_BIN=/config/telegram/Telegram
      APP_LAUNCH="$APP_BIN"
      APP_NAME=Telegram
      ;;
    chromium)
      # 容器内无 user namespace / GPU：--no-sandbox + 软件渲染；--password-store=basic 免 keyring 弹窗
      APP_BIN=/usr/bin/chromium
      APP_LAUNCH="$APP_BIN --no-sandbox --no-first-run --no-default-browser-check --start-maximized --password-store=basic --disable-gpu --user-data-dir=/config/chromium"
      APP_NAME=Chromium
      ;;
    custom)
      # 自定义：启动命令由面板写入 .woc-app 的 WOC_CUSTOM_LAUNCH（用户上传安装包后设定）
      APP_LAUNCH="${WOC_CUSTOM_LAUNCH:-}"
      APP_BIN="${WOC_CUSTOM_BIN:-}"
      APP_NAME="自定义应用"
      ;;
    *)
      APP_BIN=/config/wechat/opt/wechat/wechat
      APP_LAUNCH="$APP_BIN"
      APP_NAME=微信
      ;;
  esac
}
