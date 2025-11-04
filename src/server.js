const express = require('express');
const nodemailer = require('nodemailer');
const cors = require('cors');
const path = require('path');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// 中間件
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static('public'));

// 創建 Nodemailer 傳輸器
const createTransporter = () => {
  return nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: process.env.GMAIL_USER,
      pass: process.env.GMAIL_APP_PASSWORD
    },
    tls: {
      // 允許自簽名證書（用於某些網絡環境）
      rejectUnauthorized: false
    }
  });
};

// 健康檢查端點
app.get('/api/health', (req, res) => {
  res.json({
    status: 'ok',
    message: 'Gmail 郵件發送服務運行正常',
    timestamp: new Date().toISOString()
  });
});

// 發送郵件 API
app.post('/api/send-email', async (req, res) => {
  const { to, subject, text, html } = req.body;

  // 驗證必填欄位
  if (!to || !subject || (!text && !html)) {
    return res.status(400).json({
      success: false,
      error: '請提供收件人、主旨和郵件內容'
    });
  }

  // 檢查環境變數
  if (!process.env.GMAIL_USER || !process.env.GMAIL_APP_PASSWORD) {
    return res.status(500).json({
      success: false,
      error: '伺服器未配置 Gmail 認證資訊'
    });
  }

  try {
    const transporter = createTransporter();

    // 郵件選項
    const mailOptions = {
      from: `"Gmail Sent Out" <${process.env.GMAIL_USER}>`,
      to: to,
      subject: subject,
      text: text,
      html: html || text.replace(/\n/g, '<br>')
    };

    // 發送郵件
    const info = await transporter.sendMail(mailOptions);

    res.json({
      success: true,
      message: '郵件發送成功！',
      messageId: info.messageId,
      preview: nodemailer.getTestMessageUrl(info)
    });

  } catch (error) {
    console.error('郵件發送失敗:', error);
    res.status(500).json({
      success: false,
      error: '郵件發送失敗: ' + error.message
    });
  }
});

// 錯誤處理中間件
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({
    success: false,
    error: '伺服器內部錯誤'
  });
});

// 啟動服務器
app.listen(PORT, () => {
  console.log(`\n========================================`);
  console.log(`  Gmail Sent Out 服務器已啟動`);
  console.log(`========================================`);
  console.log(`  伺服器地址: http://localhost:${PORT}`);
  console.log(`  API 端點: http://localhost:${PORT}/api/send-email`);
  console.log(`  健康檢查: http://localhost:${PORT}/api/health`);
  console.log(`========================================\n`);

  // 檢查環境變數
  if (!process.env.GMAIL_USER || !process.env.GMAIL_APP_PASSWORD) {
    console.warn('⚠️  警告: 請設置 GMAIL_USER 和 GMAIL_APP_PASSWORD 環境變數');
    console.warn('   請複製 .env.example 為 .env 並填寫您的 Gmail 資訊\n');
  }
});
