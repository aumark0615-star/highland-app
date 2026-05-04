# Highland Shooting Club Web App

可部署的 React + Vite 前端版本。

## 功能

- 登入示範帳號
  - 管理員：admin@highland.local / 123456
  - 會員：member@highland.local / 123456
- 會員管理
- 活動建立與報名
- Division 自動判斷：SSP-A / CO-A / PCC-A / OPEN-A
- 成績輸入與自動排名
- 會員分級制度
- 選手個人生涯成績頁
  - 可從「成績」點選選手進入
  - 可查看歷史比賽、最佳名次、最佳總秒、平均總秒、主要 Division、累積分數
- localStorage 本機資料儲存

## 本機測試

```bash
npm install
npm run dev
```

## 部署到 Vercel

- Framework Preset：Vite
- Build Command：`npm run build`
- Output Directory：`dist`

## 正式資料庫

`supabase_schema.sql` 內有正式上線用的 Supabase 資料表草稿。


## 罰分明細版本

成績輸入已拆成四個官方填寫欄位：

1. Points Down（PD）：每點 +1 秒
2. Procedural Error（PE）：每次 +3 秒
3. Hits in Non-Threat（HNT）：每次 +5 秒
4. Miss：每次 +5 秒

排名使用：原始秒數 + 系統換算後罰秒 = 總秒數。
