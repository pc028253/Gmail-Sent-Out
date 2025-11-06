# 🌐 雲端部署指南

本文檔說明如何將 Avnet Ken 部署到雲端平台，實現跨平台訪問。

---

## 🎯 推薦平台

### 1. Railway（最推薦）⭐⭐⭐⭐⭐

**優點：**
- 💰 每月 $5 免費額度
- 🚀 部署超級簡單
- 🔧 自動從 GitHub 部署
- 🌍 自動 HTTPS
- ⚡ 速度快，不會休眠

**部署步驟：**

1. **註冊 Railway**
   - 訪問：https://railway.app
   - 使用 GitHub 帳號登入

2. **創建新項目**
   - 點擊 "New Project"
   - 選擇 "Deploy from GitHub repo"
   - 選擇 `Gmail-Sent-Out` 倉庫

3. **設置環境變數**
   - 在項目設置中點擊 "Variables"
   - 添加以下變數：
     ```
     GMAIL_USER=your-email@gmail.com
     GMAIL_APP_PASSWORD=your-16-digit-password
     PORT=3000
     NODE_TLS_REJECT_UNAUTHORIZED=0
     ```

4. **部署**
   - Railway 會自動部署
   - 等待構建完成（約 2-3 分鐘）

5. **獲取網址**
   - 點擊 "Settings" → "Generate Domain"
   - 您會得到一個網址，如：`https://your-app.railway.app`

6. **訪問應用**
   - 在瀏覽器中打開您的網址
   - 開始使用！

---

### 2. Render（免費方案）⭐⭐⭐⭐

**優點：**
- 💰 完全免費
- 🚀 部署簡單
- 🌍 自動 HTTPS

**缺點：**
- 閒置 15 分鐘後休眠
- 首次訪問需等待 30 秒啟動

**部署步驟：**

1. **註冊 Render**
   - 訪問：https://render.com
   - 使用 GitHub 帳號登入

2. **創建 Web Service**
   - 點擊 "New +"
   - 選擇 "Web Service"
   - 連接 GitHub 倉庫

3. **配置服務**
   - Name: `gmail-sent-out`
   - Region: Singapore（離台灣最近）
   - Branch: `claude/execution-task-011CUnrYevEer12XqeFAmypu`
   - Build Command: `npm install`
   - Start Command: `npm start`

4. **設置環境變數**
   - 在 "Environment" 標籤添加：
     ```
     GMAIL_USER=your-email@gmail.com
     GMAIL_APP_PASSWORD=your-16-digit-password
     PORT=3000
     NODE_TLS_REJECT_UNAUTHORIZED=0
     ```

5. **部署**
   - 點擊 "Create Web Service"
   - 等待部署完成

6. **訪問**
   - 使用提供的網址訪問應用

---

### 3. Heroku（付費）⭐⭐⭐

**費用：** $5/月起

**部署步驟：**

1. **安裝 Heroku CLI**
   ```bash
   # 下載：https://devcenter.heroku.com/articles/heroku-cli
   ```

2. **登入**
   ```bash
   heroku login
   ```

3. **創建應用**
   ```bash
   cd Gmail-Sent-Out
   heroku create your-app-name
   ```

4. **設置環境變數**
   ```bash
   heroku config:set GMAIL_USER=your-email@gmail.com
   heroku config:set GMAIL_APP_PASSWORD=your-16-digit-password
   heroku config:set NODE_TLS_REJECT_UNAUTHORIZED=0
   ```

5. **部署**
   ```bash
   git push heroku claude/execution-task-011CUnrYevEer12XqeFAmypu:main
   ```

6. **打開應用**
   ```bash
   heroku open
   ```

---

### 4. VPS（自己的伺服器）⭐⭐⭐⭐⭐

**平台：** DigitalOcean, Linode, Vultr
**費用：** $5/月起

**優點：**
- 💪 完全控制
- 🚀 性能最好
- 🔒 最安全

**部署步驟：**

1. **購買 VPS**
   - 選擇任一平台購買最小規格（$5/月）

2. **SSH 連接**
   ```bash
   ssh root@your-server-ip
   ```

3. **安裝 Node.js**
   ```bash
   curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
   sudo apt-get install -y nodejs
   ```

4. **克隆代碼**
   ```bash
   git clone https://github.com/pc028253/Gmail-Sent-Out.git
   cd Gmail-Sent-Out
   git checkout claude/execution-task-011CUnrYevEer12XqeFAmypu
   ```

5. **安裝依賴**
   ```bash
   npm install
   ```

6. **設置環境變數**
   ```bash
   nano .env
   # 輸入：
   GMAIL_USER=your-email@gmail.com
   GMAIL_APP_PASSWORD=your-16-digit-password
   PORT=3000
   ```

7. **安裝 PM2（保持運行）**
   ```bash
   sudo npm install -g pm2
   NODE_TLS_REJECT_UNAUTHORIZED=0 pm2 start src/server.js --name gmail-app
   pm2 startup
   pm2 save
   ```

8. **配置 Nginx（可選，用於 HTTPS）**
   ```bash
   sudo apt install nginx
   sudo nano /etc/nginx/sites-available/gmail
   ```

9. **訪問**
   - 瀏覽器打開：`http://your-server-ip:3000`

---

## 🔒 安全提示

### ⚠️ 重要安全事項

1. **不要公開 .env 檔案**
   - 永遠不要提交 .env 到 Git
   - 已包含在 .gitignore 中

2. **環境變數安全**
   - 在雲端平台的管理界面設置
   - 不要在代碼中寫死

3. **訪問控制（建議）**
   - 考慮添加密碼保護
   - 限制特定 IP 訪問
   - 添加使用者認證

4. **HTTPS**
   - Railway 和 Render 自動提供 HTTPS
   - VPS 需要配置 SSL 證書（使用 Let's Encrypt）

5. **API 限制**
   - 考慮添加發送頻率限制
   - 防止濫用

---

## 🌍 訪問您的應用

部署完成後，您可以：

- ✅ 從任何裝置訪問（手機、平板、電腦）
- ✅ 分享給團隊成員使用
- ✅ 無需安裝任何軟體
- ✅ 自動備份和更新

**範例網址：**
- Railway: `https://gmail-sent-out.up.railway.app`
- Render: `https://gmail-sent-out.onrender.com`
- 自訂域名: `https://mail.yourdomain.com`（需配置 DNS）

---

## 📊 平台對比

| 平台 | 費用 | 難度 | 速度 | 穩定性 | 推薦度 |
|------|------|------|------|--------|--------|
| Railway | $5/月免費額度 | ⭐ | ⚡⚡⚡⚡⚡ | ✅✅✅✅✅ | ⭐⭐⭐⭐⭐ |
| Render | 免費 | ⭐⭐ | ⚡⚡⚡ | ✅✅✅✅ | ⭐⭐⭐⭐ |
| Heroku | $5/月起 | ⭐⭐ | ⚡⚡⚡⚡ | ✅✅✅✅✅ | ⭐⭐⭐ |
| VPS | $5/月起 | ⭐⭐⭐⭐ | ⚡⚡⚡⚡⚡ | ✅✅✅✅✅ | ⭐⭐⭐⭐⭐ |

---

## 💡 建議

**個人使用：** Railway（最簡單，不會休眠）
**偶爾使用：** Render（完全免費）
**團隊使用：** VPS（最穩定）
**企業使用：** VPS + 專業配置

---

## 🆘 需要幫助？

如果部署遇到問題，請檢查：
1. 環境變數是否正確設置
2. Gmail 應用程式密碼是否有效
3. 查看部署日誌中的錯誤訊息

---

## 🔄 自動部署

設置自動部署後，每次推送到 GitHub，雲端應用會自動更新：

**Railway / Render：**
- 自動監聽 GitHub 倉庫
- 推送代碼後自動部署
- 無需手動操作

**VPS：**
- 可以設置 GitHub Webhook
- 或使用 `git pull` 手動更新
- 需要重啟服務：`pm2 restart gmail-app`
