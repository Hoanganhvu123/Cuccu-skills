# Quy Luật Lập Trình (Coding Rules & Agent Guidelines)

Bất kỳ AI Agent nào (Claude Code, Forge) trước khi code phải đọc kỹ các Rule của dự án Cuccu Sales AI SaaS.

## 1. 4 Nguyên tắc "Chấn phái" (Theo chuẩn Andrej Karpathy)

> Các Rule này đã được nạp trong file `CLAUDE.md` ngoài root. Chi tiết như sau:

- **1. Suy Nghĩ Trước Khi Code (Think Before Coding):**
  Không tự đoán. Nếu không hiểu kiến trúc thì phải gọi lệnh báo lỗi hỏi người dùng. Đưa ra các trường hợp (tradeoffs) trước khi quyết định viết đè file.
- **2. Đơn Giản Là Nhất (Simplicity First):**
  Không viết dư tính năng chưa ai yêu cầu. Không đẻ ra Wrapper Class hay Abstraction nếu nó chỉ gọi 1 lần. Backend FastAPI càng thuần càng tốt.
- **3. Phẫu Thuật Chính Xác (Surgical Changes):**
  Hỏng đâu sửa đó. Bạn đang chỉnh sửa Route `workflows.py` thì không được "ngứa tay" qua dọn dẹp biến ở `main.py` hay dọn dẹp thư viện không liên quan, trừ phi nó break hoàn toàn code hiện tại. Format đúng theo style code cũ đang có.
- **4. Code Mục Tiêu & Vòng Lặp Test (Goal-Driven Execution):**
  Khi được yêu cầu viết tính năng, ví dụ "Viết API lấy user", việc đầu tiên phải chạy `pytest` hoặc viết Unit Test Fail trước, sau đó code sao cho test Pass. Chạy test lại liên tục bằng terminal sau mỗi lần sửa.

## 2. Tiêu Chuẩn Kỹ Thuật Dự Án (Tech Stack Conventions)

### [BACKEND] (FastAPI)
1. **DB Framework:** Bắt buộc dùng `asyncpg` theo cấu trúc Core Pool hiện có (`common/postgres_client.py`). **Không dùng SQLAlchemy** hoặc các ORM làm cục súc hiệu năng hệ thống.
2. **Schema Validation:** Data đầu vào và đầu ra phải 100% bọc qua Pydantic Class định nghĩa trong folder `schemas/`. Tránh trả về Dict `{"a": 1}` tự do.
3. **Môi Trường Testing:** Luôn phải cô lập DB khi Test vòng Unit. Mọi thay đổi không được ghi đè bản ghi có thực trong PostgreSQL (Sử dụng Fixture mock với SQLite hoặc `pytest-mock` trả fake Dict data).

### [FRONTEND] (React + Vite)
1. **TailwindCSS & Shadcn UI:** Không được dùng file CSS thả rông `.css` trừ mục `index.css`. Mọi UI Design phải dùng Utility Class của Tailwind. Ưu tiên xài component có sẵn trong `components/ui`.
2. **State & Fetch:** Mặc định gọi API bằng `axios` trỏ tới `/api/`. Không Hardcode domain tuyệt đối (ví dụ `http://localhost:8000/api`) vì Vite Proxy sẽ xử lý chuyển hướng chéo hông (CORS free).

---
*Kỷ luật là sức mạnh hệ thống. Kẻ viết sai rule sẽ phá hoại ứng dụng. Hãy code cẩn thận vì dự án này của Bro.*
