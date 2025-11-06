# Avnet Ken 📧

透過 Gmail SMTP 服務發送郵件的網頁應用程式

## ✨ 功能特色

- 🎨 **美觀的網頁界面** - 簡潔易用的郵件發送表單
- 📧 **Gmail 整合** - 使用 Gmail SMTP 服務發送郵件
- ⚡ **即時反饋** - 發送狀態即時顯示
- 🔒 **安全可靠** - 使用 Gmail 應用程式密碼
- 📱 **響應式設計** - 支援各種裝置

## 🚀 快速開始

### 1. 安裝依賴

```bash
npm install
```

### 2. 設定 Gmail 認證

#### 步驟 A: 啟用 Google 兩步驟驗證

1. 前往 [Google 帳戶安全性設定](https://myaccount.google.com/security)
2. 找到「登入 Google」區塊
3. 點擊「兩步驟驗證」並啟用

#### 步驟 B: 生成應用程式密碼

1. 在安全性設定頁面，找到「應用程式密碼」
2. 選擇「郵件」作為應用程式
3. 選擇「其他」作為裝置，輸入「Avnet Ken」
4. 點擊「產生」
5. 複製顯示的 16 位密碼（格式：xxxx xxxx xxxx xxxx）

#### 步驟 C: 設定環境變數

```bash
# 複製範例檔案
cp .env.example .env

# 編輯 .env 檔案，填入您的資訊
# GMAIL_USER=your-email@gmail.com
# GMAIL_APP_PASSWORD=your-16-digit-app-password
```

### 3. 啟動應用程式

```bash
# 正式環境
npm start

# 開發環境（自動重啟）
npm run dev
```

應用程式將在 http://localhost:3000 啟動

## 📖 使用方式

### 網頁界面

1. 在瀏覽器開啟 http://localhost:3000
2. 填寫表單：
   - **收件人**: 輸入收件人的電子郵件地址
   - **主旨**: 郵件主旨
   - **內容**: 郵件內容
3. 點擊「發送郵件」按鈕
4. 等待發送結果

### API 使用

#### 發送郵件

```bash
curl -X POST http://localhost:3000/api/send-email \
  -H "Content-Type: application/json" \
  -d '{
    "to": "recipient@example.com",
    "subject": "測試郵件",
    "text": "這是一封測試郵件"
  }'
```

#### 健康檢查

```bash
curl http://localhost:3000/api/health
```

## 🛠️ API 文檔

### POST /api/send-email

發送電子郵件

**請求 Body:**

```json
{
  "to": "recipient@example.com",
  "subject": "郵件主旨",
  "text": "純文字內容",
  "html": "<h1>HTML 內容</h1> (選填)"
}
```

**成功響應:**

```json
{
  "success": true,
  "message": "郵件發送成功！",
  "messageId": "<message-id>"
}
```

**錯誤響應:**

```json
{
  "success": false,
  "error": "錯誤訊息"
}
```

### GET /api/health

檢查服務狀態

**響應:**

```json
{
  "status": "ok",
  "message": "Gmail 郵件發送服務運行正常",
  "timestamp": "2025-11-01T12:00:00.000Z"
}
```

## 📁 專案結構

```
avnet-ken/
├── src/
│   └── server.js          # Express 伺服器
├── public/
│   └── index.html         # 前端界面
├── .env.example           # 環境變數範例
├── .gitignore            # Git 忽略規則
├── package.json          # 專案配置
└── README.md             # 專案文檔
```

## ⚙️ 環境變數

| 變數 | 說明 | 必填 |
|------|------|------|
| `GMAIL_USER` | 您的 Gmail 郵箱地址 | ✅ |
| `GMAIL_APP_PASSWORD` | Gmail 應用程式密碼 | ✅ |
| `PORT` | 伺服器端口 | ❌ (預設: 3000) |

## 🔒 安全提示

1. **永遠不要提交 `.env` 檔案到 Git**
2. **使用應用程式密碼**，不要使用您的 Gmail 主密碼
3. **定期更換應用程式密碼**
4. **限制發送頻率**，避免被 Gmail 標記為垃圾郵件
5. **不要在公開網路暴露此服務**

## 📊 技術棧

- **後端**: Node.js + Express.js
- **郵件服務**: Nodemailer
- **前端**: HTML + CSS + JavaScript
- **環境管理**: dotenv

## 🐛 故障排除

### 問題 1: 郵件發送失敗 - "Invalid login"

**解決方法:**
- 確認已啟用 Google 兩步驟驗證
- 確認使用的是應用程式密碼，而非 Gmail 主密碼
- 檢查 `.env` 檔案中的 `GMAIL_USER` 和 `GMAIL_APP_PASSWORD` 是否正確

### 問題 2: 郵件發送失敗 - "Daily sending quota exceeded"

**解決方法:**
- Gmail 有每日發送限制（約 500 封/天）
- 等待 24 小時後再試
- 考慮使用多個 Gmail 帳號輪流發送

### 問題 3: 伺服器無法啟動

**解決方法:**
```bash
# 確保依賴已安裝
npm install

# 檢查端口是否被占用
lsof -i :3000

# 使用不同端口
PORT=3001 npm start
```

## 📝 開發計畫

- [ ] 添加郵件模板功能
- [ ] 支援附件上傳
- [ ] 郵件發送歷史記錄
- [ ] 批量發送功能
- [ ] 支援其他郵件服務（Outlook、SendGrid 等）
- [ ] 添加使用者認證
- [ ] API 使用限制

## 🤝 貢獻

歡迎提交 Pull Request 或回報問題！

## 📄 授權

MIT License

## 👨‍💻 作者

Created with ❤️ by Claude Code Assistant

## 🔗 相關連結

- [Nodemailer 文檔](https://nodemailer.com/)
- [Gmail SMTP 設定](https://support.google.com/mail/answer/7126229)
- [Google 應用程式密碼說明](https://support.google.com/accounts/answer/185833)

---

**注意**: 此應用程式僅供學習和個人使用，請遵守 Gmail 的使用條款和限制。
