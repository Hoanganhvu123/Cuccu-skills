# Ý Tưởng & Chiến Lược Thực Thi (Cuccu Sales AI)

Tài liệu này định hướng bức tranh nghiệp vụ và vai trò của Backend / Frontend trong hệ thống Sales Automation Workflow. (Cập nhật liên tục khi phát sinh Idea mới).

## 1. Tầm Nhìn Sản Phẩm (Product Idea)
- Đây là một **Mini n8n cho dân chốt sale**. 
- Thay vì cấu hình chatbot tĩnh, User kéo thả một Workflow: `Khách vào nhắn -> Ai phân tích Intent -> Nếu muốn mua: Cầm mã sản phẩm đi hỏi API check tồn kho -> Còn hàng -> AI Tự sinh tin nhắn chốt đơn`.

## 2. Việc của Backend (BE) làm thế nào?
Backend là Trái Tim (được viết bằng **FastAPI**).
- Gồm các Router quản lý: Webhook, Khách hàng, Sản phẩm, CRM Inbox.
- Lõi là `workflows.py`: Lưu cấu trúc Node/Edge do User kéo thả.
- **Tiếp theo BE phải làm gì?**
  1. **Tạo Mock Test Framework:** Viết code tự tráo lõi Data `asyncpg` sang *In-Memory SQLite* hoặc Mock Data tĩnh. (Không được chạm DB thật khi chạy unit test).
  2. **Viết Workflow Execution Engine:** Xây dựng cục Engine thực thi graph. Khi Frontend nhấn luồng "Chạy thử", Backend đệ quy chạy từng Node (Ví dụ: `Logic Node` để vạch đường, gọi `Mcp Node` chọc vào DB lấy giá sản phẩm, gọi `Agent Node` cho GPT-4o-mini đẻ ra chữ có tuỳ chọn **SSE Stream** trả về Frontend).
  3. **Bridge Webhook Thực Tế:** Cho ghép nối Facebook / Zalo vào `/api/webhooks`.

## 3. Việc của Frontend (FE) làm thế nào?
Frontend là Bảng Điều Khiển (được viết bằng **React + Vite + Shadcn/Tailwind**). Nằm trong thư mục `/frontend/`.
- Frontend có `React Flow` để quản lý giao diện vẽ Biểu Đồ (Canvas).
- **Tiếp theo FE phải làm gì?**
  1. Xóa bỏ hoặc bỏ qua hoàn toàn các file `.html` tĩnh đang được render bởi thẻ Jinja2 ở Backend. Cắt đứt sự phụ thuộc của FE vào server FastAPI.
  2. Map config Vite proxy: Override config cổng Vite để proxy mọi request `/api/*` tới thẳng `http://localhost:8000` (FastAPI).
  3. Hiển thị Stream Message (SSE) khi Workflow chạy.

---

*Lưu ý: Bất kỳ Agent AI nào (Claude, Forge) khi nhận Task mới, hãy mở file này ra xem BE/FE đang ở giai đoạn nào để nắm Context.*

---

## 4. CuCu Note — Mini-App Note-Taking (Memos-based)

Nằm ở `miniapp/cuccu_note/`. Đây là một **note-taking app** được fork từ Memos, tích hợp thêm:
- **Teams & Workspace** — quản lý nhóm
- **Deadline & Priority** — gắn deadline cho mỗi note
- **AI Chatbot** — hỏi đáp với OpenAI về nội dung notes
- **Anonymous notes** — ghi chú không cần đăng nhập

### Trạng thái hiện tại:
- ✅ Core: Auth, CRUD Memo, Pin, Archive, Tags, Attachments, Version History
- 🔧 Đang làm: Reactions & Comments (Epic 1 — code xong, chờ test)
- ❌ Chưa làm: Inbox Notifications, PAT, Webhooks, SSO

### File kế hoạch chi tiết:
- `plan/doings/cuccu-note-feature-parity.md` — Tasks đang làm
- `plan/ideas/cuccu-note-next-features.md` — Ideas tương lai (AI, Kanban, Templates...)
