# 推送到 GitHub 指南

## 📋 快速步驟總覽

1. ✅ 在 GitHub 網站創建倉庫
2. ✅ 執行推送腳本
3. ✅ 驗證推送成功

---

## 方式 A: 使用自動化腳本（推薦）

### 步驟 1: 在 GitHub 創建倉庫

1. 前往：https://github.com/new
2. 填寫資訊：
   - **Repository name**: `gmail-sent-out`
   - **Description**: `透過 Gmail 發送郵件的網頁應用程式`
   - **Visibility**: Public 或 Private
3. ⚠️ **不要勾選任何初始化選項**
4. 點擊 **Create repository**

### 步驟 2: 執行推送腳本

在終端機中執行：

```bash
cd /home/user/gmail-sent-out
./push-to-github.sh
```

腳本會自動：
- 檢查 Git 狀態
- 要求您輸入 GitHub 用戶名
- 配置遠程倉庫
- 推送到 GitHub

### 步驟 3: 輸入認證資訊

當提示時輸入：
- **Username**: 您的 GitHub 用戶名
- **Password**: Personal Access Token

---

## 方式 B: 手動操作

### 步驟 1: 在 GitHub 創建倉庫（同上）

### 步驟 2: 添加遠程倉庫

```bash
cd /home/user/gmail-sent-out

# 替換 YOUR_USERNAME 為您的 GitHub 用戶名
git remote add origin https://github.com/YOUR_USERNAME/gmail-sent-out.git
```

### 步驟 3: 驗證配置

```bash
git remote -v
```

### 步驟 4: 推送到 GitHub

```bash
git branch -M main
git push -u origin main
```

---

## 🔑 如何取得 Personal Access Token

### 步驟 1: 前往 Token 設定頁面

訪問：https://github.com/settings/tokens

### 步驟 2: 生成新 Token

1. 點擊 **Generate new token** → **Generate new token (classic)**
2. 填寫資訊：
   - **Note**: `Gmail Sent Out`
   - **Expiration**: `90 days`
   - **Select scopes**: 勾選 `repo` (完整倉庫權限)

### 步驟 3: 生成並保存

1. 點擊 **Generate token**
2. ⚠️ **立即複製 Token** (格式：`ghp_xxxxx...`)
3. 保存到安全的地方（只會顯示一次！）

### 步驟 4: 使用 Token

推送時：
- Username: 輸入 GitHub 用戶名
- Password: 粘貼 Personal Access Token

---

## 📊 推送成功驗證

推送成功後，您應該看到：

```
Enumerating objects: 10, done.
Counting objects: 100% (10/10), done.
Delta compression using up to 8 threads
Compressing objects: 100% (9/9), done.
Writing objects: 100% (10/10), 7.50 KiB | 7.50 MiB/s, done.
Total 10 (delta 0), reused 0 (delta 0), pack-reused 0
To https://github.com/YOUR_USERNAME/gmail-sent-out.git
 * [new branch]      main -> main
Branch 'main' set up to track remote branch 'main' from 'origin'.
```

### 訪問您的倉庫

```
https://github.com/YOUR_USERNAME/gmail-sent-out
```

---

## 🐛 常見問題

### 問題 1: remote origin already exists

**解決方法：**
```bash
git remote remove origin
git remote add origin https://github.com/YOUR_USERNAME/gmail-sent-out.git
```

### 問題 2: Authentication failed

**原因：** Personal Access Token 不正確或已過期

**解決方法：**
1. 重新生成 Personal Access Token
2. 確保勾選了 `repo` 權限
3. 使用新的 Token 重試

### 問題 3: Repository not found

**原因：** GitHub 倉庫尚未創建或用戶名錯誤

**解決方法：**
1. 確認已在 GitHub 網站創建倉庫
2. 檢查用戶名拼寫是否正確
3. 確認倉庫名稱為 `gmail-sent-out`

### 問題 4: ! [rejected] ... (fetch first)

**原因：** 遠程倉庫有本地沒有的提交

**解決方法：**
```bash
git pull origin main --allow-unrelated-histories
git push -u origin main
```

---

## 🎉 推送成功後

### 1. 添加倉庫描述

在 GitHub 倉庫頁面：
1. 點擊 ⚙️ Settings
2. 編輯 Description
3. 添加 Website（如果有）

### 2. 添加主題標籤 (Topics)

建議標籤：
- `gmail`
- `email`
- `nodemailer`
- `express`
- `nodejs`
- `smtp`
- `email-sender`

### 3. 創建 GitHub Pages（選填）

如果想托管靜態前端：
1. Settings → Pages
2. Source 選擇 `main` 分支
3. 保存

### 4. 保護主分支（選填）

Settings → Branches → Add rule:
- Branch name pattern: `main`
- ✅ Require pull request reviews before merging

---

## 📝 後續操作

### 日常提交流程

```bash
# 1. 修改代碼
# 2. 添加更改
git add .

# 3. 提交更改
git commit -m "描述您的更改"

# 4. 推送到 GitHub
git push
```

### 查看遠程倉庫

```bash
git remote -v
```

### 同步遠程更改

```bash
git pull origin main
```

---

**提示**: 如有問題，請查看 GitHub 官方文檔：https://docs.github.com/
