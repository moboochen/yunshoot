#!/usr/bin/env bash
# ==============================================================================
# Q版特種部隊：現代突擊 3D - Mac 本地一鍵雙擊執行檔 (自動啟動本機伺服器與 iPad Wi-Fi 對戰)
# ==============================================================================

# 切換到腳本所在資料夾
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

echo "=========================================================="
echo "🎖️  歡迎啟動《Q版特種部隊：現代突擊 3D》Mac 本地對戰主機"
echo "=========================================================="
echo ""

# 取得 Mac 區域網路 IP (Wi-Fi en0 或 有線 en1)
MAC_IP=$(ipconfig getifaddr en0 2>/dev/null)
if [ -z "$MAC_IP" ]; then
  MAC_IP=$(ipconfig getifaddr en1 2>/dev/null)
fi
if [ -z "$MAC_IP" ]; then
  MAC_IP="127.0.0.1"
fi

PORT=8080

echo "🚀 本地伺服器已在連接埠 $PORT 啟動！"
echo ""
echo "📱 [iPad / 手機連線方式]："
echo "   請確認 iPad 與 Mac 連接同一個 Wi-Fi，在 iPad Safari 輸入："
echo "   👉 http://$MAC_IP:$PORT/game.html"
echo ""
echo "💻 [Mac 本機連線方式]："
echo "   正在為您自動開啟預設瀏覽器..."
echo "   👉 http://localhost:$PORT/game.html"
echo ""
echo "💡 提示：關閉此終端機視窗即可停止伺服器。"
echo "=========================================================="

# 在 Mac 上自動開啟遊戲頁面
(sleep 1 && open "http://localhost:$PORT/game.html") &

# 啟動 Python 輕量本地伺服器
if command -v python3 >/dev/null 2>&1; then
  python3 -m http.server $PORT
elif command -v python >/dev/null 2>&1; then
  python -m SimpleHTTPServer $PORT
else
  # 若未安裝 Python，直接使用 open 指令以 file:// 協定打開單一自包含 HTML
  echo "未偵測到 Python，直接以瀏覽器本地開啟 HTML..."
  open "$DIR/game.html"
fi
