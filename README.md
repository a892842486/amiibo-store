# 任天堂 amiibo 專賣（Demo）

以 Ruby on Rails 8 開發的全端電商網站，
包含商品瀏覽、購物車、訂單管理與後台功能。

專案實作 Devise 驗證、AASM 訂單狀態機、
AWS S3 圖片儲存、Action Mailer 與 i18n 多語系切換。

開發過程中曾遇到 Bootstrap 與 Rails 8 相容性問題，
最終改以 Tailwind CSS 重構前端並完成部署。

<img width="1920" height="1080" alt="amiibo-store-home" src="https://github.com/user-attachments/assets/c2252c80-bba0-40cf-aff7-c5180ba387a0" />

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

---

## Screenshots

### Storefront

#### 1. Homepage

<img width="1920" height="1080" alt="01-amiibo-store-home" src="https://github.com/user-attachments/assets/7d87593f-ef2c-4151-be63-50b48b0eb7f2" />

#### 2. Product Listing

<img width="1920" height="1080" alt="02-amiibo-store-product" src="https://github.com/user-attachments/assets/f5b831eb-8750-42f2-89e1-96d9b82335de" />

#### 3. Product Details

<img width="1920" height="1080" alt="03-amiibo-store-product-show" src="https://github.com/user-attachments/assets/298b6a3e-33b0-4217-8f82-db3e14fc1277" />

#### 4. Shopping Cart

<img width="1920" height="1080" alt="04-amiibo-store-cart" src="https://github.com/user-attachments/assets/78c431bb-1ab4-4a26-b055-b0852b9cc9f4" />

#### 5. Checkout

<img width="1920" height="1080" alt="05-amiibo-store-checkout" src="https://github.com/user-attachments/assets/d93fc7d6-ddcc-4054-bf00-1231ee43c554" />

#### 6. Order Details

<img width="1920" height="1080" alt="06-amiibo-store-order-show" src="https://github.com/user-attachments/assets/302f2d76-218d-46f7-b6f8-28d5aa6e5974" />

<details>
<summary>More Screenshots</summary>

### Order Notification

#### 7. Order Confirmation Email

<img width="1920" height="1080" alt="07-amiibo-store-order-email" src="https://github.com/user-attachments/assets/e80715cb-9d42-49ce-8add-08f97c39562f" />

### Admin Dashboard

#### 8. Product Management

<img width="1920" height="1080" alt="08-amiibo-store-admin-products" src="https://github.com/user-attachments/assets/45e083fd-cbc8-4ce5-9241-c3956d1232d5" />

#### 9. Order Management

<img width="1920" height="1080" alt="09-amiibo-store-admin-orders" src="https://github.com/user-attachments/assets/71d8c709-67e5-48e3-a3cc-c09e3ae090f9" />

#### 10. Admin Order Details

<img width="1920" height="1080" alt="10-amiibo-store-admin-order-show" src="https://github.com/user-attachments/assets/5883e58b-c29c-40e1-af09-f84791c3c755" />

### Internationalization

#### 11. English UI Preview

<img width="1920" height="1080" alt="11-amiibo-store-i18n" src="https://github.com/user-attachments/assets/5f3c8eb7-3505-4a2b-9e2c-d8840d4c3b0e" />

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
