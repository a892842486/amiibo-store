# 任天堂 amiibo 專賣（Demo）

以 Ruby on Rails 8 開發的全端電商網站，
包含商品瀏覽、購物車、訂單管理與後台功能。

專案實作 Devise 驗證、AASM 訂單狀態機、
AWS S3 圖片儲存、Action Mailer 與 i18n 多語系切換。

開發過程中曾遇到 Bootstrap 與 Rails 8 相容性問題，
最終改以 Tailwind CSS 重構前端並完成部署。

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/db7393b2-1b56-4282-8883-7b5091d0412c" />

---

## 🔗 Links

| | |
|---|---|
| 🌐 Live Demo | [jdstore20260510.onrender.com](https://jdstore20260510.onrender.com/) |
| 📁 GitHub | [github.com/a892842486/amiibo-store](https://github.com/a892842486/amiibo-store) |

> ⚠️ 部署於 Render 免費方案，首次開啟可能需要等待約 30 秒啟動。

## 🔑 Demo Account

| 角色  | Email          | Password |
|-------|----------------|----------|
| Admin | admin@test.com | 123456   |
| User  | user@test.com  | 123456   |

---

## Features

### Storefront（前台）
- 商品列表、詳情瀏覽
- 購物車管理（新增、修改數量、刪除）
- 結帳與訂單建立流程
- 訂單狀態追蹤與歷史查詢
- 使用者註冊 / 登入（Devise）
- Email 訂單通知（下單、出貨、取消）
- 中英文 i18n 多語系切換

### Admin Dashboard（後台）
- 商品 CRUD（含圖片上傳至 AWS S3）
- 訂單列表管理
- 訂單狀態流轉操作（付款確認、出貨、取消）

### Email Notifications（寄信通知）
使用 Action Mailer 實作：
- 下單通知信
- 出貨通知信
- 訂單取消通知
- 管理員取消申請通知
支援訂單資訊與 i18n 多語系信件標題。

### Order State Machine（AASM）

使用 AASM 實作訂單狀態管理，確保狀態流轉的合法性與業務邏輯一致性。

```mermaid
stateDiagram-v2
    [*] --> order_placed : 建立訂單
    order_placed --> paid : 付款確認
    paid --> shipping : 開始出貨
    shipping --> shipped : 出貨完成
    order_placed --> order_cancelled : 取消
    paid --> order_cancelled : 取消
    shipped --> good_returned : 退貨
```

---

## Tech Stack
| 分類 | 技術 |
|------|------|
| Backend | Ruby on Rails 8、PostgreSQL |
| 認證 | Devise |
| 狀態機 | AASM |
| 信件 | Action Mailer |
| 檔案儲存 | Active Storage + AWS S3 |
| Frontend | Tailwind CSS |
| 部署 | Render |

---

## 挑戰與學習

Bootstrap 與 Rails 8 的兼容性問題

在專案初期曾嘗試使用 Bootstrap，
但因 Rails 8 與部分套件版本整合問題，
最終改以 Tailwind CSS 重構前端樣式。

透過此過程學習：
- Rails asset pipeline 設定
- CSS framework 整合方式
- Tailwind utility-first 開發流程

## 未來改善方向

- 串接金流（Stripe / 綠界）
- 商品搜尋與分類篩選
- RSpec 測試
- Docker 化部署
- CI/CD workflow
- Redis / Sidekiq 背景工作

---

## Screenshots

### Storefront

Homepage
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/db7393b2-1b56-4282-8883-7b5091d0412c" />

Product Page
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/e361614c-b053-4bb2-939f-48081d0d2c02" />

Shopping Cart
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/13dfc00e-a3d5-4ed5-83f2-efd80b2b8ac8" />

Checkout Page
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/a1443cef-56ad-480e-a235-2739c0583047" />

Order Detail
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/4943769a-29f3-47a9-8672-9a88f0e8a4db" />

<details>
<summary>More Screenshots</summary>
Order History
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/a09edd2e-4c56-4c43-a483-527e62b8fdfc" />

### Admin Dashboard

Admin Dashboard
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/4d316ff3-30f7-42e0-822a-1359e81abe0d" />
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/ae0561e1-7a7c-405d-84b5-8717b575e725" />

### Authentication

Login/Register
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/0c20d6b4-4798-4379-a1b3-775f4089c73e" />
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/58c9843a-a640-4e94-81ee-854957c7f8d8" />

### Additional Features

Email Preview
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/6586af2a-c2ca-4680-9caf-7046a7895727" />

i18n Preview
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/f998db8c-a36b-4fe3-9693-d314a7b7a93d" />
</details>
---

## ⚙️ Installation

### 環境需求

- Ruby 3.x（建議 3.2+）
- PostgreSQL
- Node.js（Tailwind CSS 編譯用）

### 步驟

```bash
git clone https://github.com/a892842486/amiibo-store.git
cd amiibo-store
bundle install
```

### 環境變數設定（選填）

本機開發不需要設定即可正常執行。
若需測試 AWS S3 圖片上傳功能，複製範例檔並填入金鑰：

```bash
cp .env.example .env
```

### 啟動

```bash
rails db:create db:migrate db:seed
rails server
```

開啟 [http://localhost:3000](http://localhost:3000)
