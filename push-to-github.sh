#!/bin/bash

# Gmail Sent Out - GitHub 推送腳本
# 請先在 GitHub 網站創建倉庫：https://github.com/new
# 倉庫名稱：gmail-sent-out

echo "=========================================="
echo "Gmail Sent Out - 推送到 GitHub"
echo "=========================================="
echo ""

# 1. 進入專案目錄
cd /home/user/gmail-sent-out
echo "✅ 已進入專案目錄"

# 2. 檢查 Git 狀態
echo ""
echo "📊 檢查 Git 狀態..."
git status

# 3. 查看提交歷史
echo ""
echo "📜 提交歷史："
git log --oneline

# 4. 提示用戶輸入 GitHub 用戶名
echo ""
echo "=========================================="
echo "請輸入您的 GitHub 用戶名："
read -p "GitHub Username: " GITHUB_USERNAME

# 5. 添加遠程倉庫
echo ""
echo "🔗 添加遠程倉庫..."
REMOTE_URL="https://github.com/${GITHUB_USERNAME}/gmail-sent-out.git"
git remote add origin "$REMOTE_URL" 2>/dev/null || git remote set-url origin "$REMOTE_URL"
echo "✅ 遠程倉庫設置完成：$REMOTE_URL"

# 6. 驗證遠程倉庫
echo ""
echo "🔍 驗證遠程倉庫配置..."
git remote -v

# 7. 確保分支名稱為 main
echo ""
echo "📌 確保分支名稱為 main..."
git branch -M main
echo "✅ 分支名稱已設為 main"

# 8. 準備推送
echo ""
echo "=========================================="
echo "🚀 準備推送到 GitHub"
echo "=========================================="
echo ""
echo "即將執行：git push -u origin main"
echo ""
echo "⚠️  注意："
echo "   - Username: 輸入您的 GitHub 用戶名"
echo "   - Password: 輸入 Personal Access Token（不是密碼！）"
echo ""
echo "如何取得 Personal Access Token："
echo "   1. 前往 https://github.com/settings/tokens"
echo "   2. 點擊 'Generate new token (classic)'"
echo "   3. 勾選 'repo' 權限"
echo "   4. 生成並複製 Token"
echo ""
read -p "按 Enter 繼續推送..."

# 9. 推送到 GitHub
git push -u origin main

# 10. 完成
if [ $? -eq 0 ]; then
    echo ""
    echo "=========================================="
    echo "✅ 推送成功！"
    echo "=========================================="
    echo ""
    echo "🎉 您的專案已上傳到 GitHub！"
    echo ""
    echo "📍 倉庫位置："
    echo "   https://github.com/${GITHUB_USERNAME}/gmail-sent-out"
    echo ""
    echo "🔗 下一步："
    echo "   1. 訪問上面的網址查看您的倉庫"
    echo "   2. 可以編輯倉庫描述和設定"
    echo "   3. 添加主題標籤 (Topics)"
    echo ""
else
    echo ""
    echo "=========================================="
    echo "❌ 推送失敗"
    echo "=========================================="
    echo ""
    echo "可能的原因："
    echo "   1. GitHub 倉庫尚未創建"
    echo "   2. Personal Access Token 不正確"
    echo "   3. 網路連線問題"
    echo "   4. 用戶名輸入錯誤"
    echo ""
    echo "請檢查以上問題後重試"
    echo ""
fi
