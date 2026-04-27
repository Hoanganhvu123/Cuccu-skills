# Kế hoạch "Bóc tách" 302_avatar_maker & Chuyển hệ sang VidFash

Bro thông cảm nãy hơi "văn vẻ" chung chung. Giờ mình đi thẳng vào vấn đề kỹ thuật (Technical Extraction). Đây là kế hoạch "rút ruột" những cấu hình, API và logic ngon nhất của thằng `302_avatar_maker` (React/Next.js) để mang về xào nấu lại cho `VidFash` (Vue.js + Python).

## 📦 1. Tầng Backend (API & Logic cốt lõi)
Mình đã soi kỹ file `app/api/generate/route.ts` và `service.ts` của nó. Bản chất nó gọi qua API model **Flux Selfie** của 302.ai, truyền vào thông số cực kỳ chi tiết.

- `[ ]` **Bê nguyên dàn Prompts bí mật (Core Logic):**
  - Mở file `app/api/generate/route.ts` của nó.
  - "Ăn cắp" sạch sẽ 12 bộ `getPrompt()` cực kỳ chi tiết (ví dụ: `TOK's headshot rendered in vibrant comic book style...`). Chữ `TOK` là từ khoá để thay thế giới tính (male/female/kid).
  - Lấy sạch các tham số cấu hình tĩnh ép cho từng style để ảnh ra đẹp nhất (ví dụ Comic Style nó ép cứng `true_cfg: 2`, `id_weight: 0.75`, `guidance_scale: 3`).
  - Nhiệm vụ: Mang đống cấu hình này dán vào một file dictionary trong Backend Python của VidFash (ví dụ: `backend/api/avatar_prompts.py`).

- `[ ]` **Viết lại API Endpoint (FastAPI):**
  - Dựng 1 route `/api/avatar/generate` bên backend Python.
  - Nhận payload từ Frontend gửi lên: `image_base64`, `preset_style` (vd: 'Comic Style'), `character_type` ('a male').
  - Thực hiện logic `replace('TOK', character_type)` vào prompt.
  - Gọi request lên API của 302.ai (hoặc ComfyUI nội bộ) y hệt như cách thằng kia gọi.

## 🎨 2. Tầng Frontend (Giao diện Vue.js)
Thằng gốc dùng React, mình sẽ "dịch" nó sang Vue + đập giao diện Dark Mode B2B SaaS vừa làm vào.

- `[ ]` **Trích xuất Data & Assets:**
  - Copy toàn bộ ảnh minh hoạ của 12 styles từ thư mục `public/images/` của nó ném sang `src/assets/avatars/` của VidFash.
  - "Móc" cái mảng cấu hình `PresetStyle` trong `lib/constant.ts` của nó sang xài thành Array data bên Vue.

- `[ ]` **Dựng layout màn hình `AvatarView.vue`:**
  - Chia Grid 2 cột rõ ràng.
  - **Cột trái (Settings):** Khối Upload ảnh Selfie bự chảng. Bên dưới là danh sách 12 styles dạng lưới (dùng `v-for`). Thẻ style thiết kế theo chuẩn Botika (nền đen `#111`, bo góc 14px, viền mờ). Click vào thẻ nào thì thẻ đó sáng lên. Thêm mục chọn Giới tính.
  - **Cột phải (Preview):** Nút **"Generate Avatar"** màu gradient nổi bật. Khung hiển thị kết quả bự.

- `[ ]` **Viết Logic Vue (State & Gọi API):**
  - Khởi tạo các biến `ref()`: `selectedImage`, `selectedStyle`, `isGenerating`, `resultImageUrl`.
  - Khớp nối sự kiện: Bấm "Generate" -> gọi Axios POST gọi API Backend -> đổi biến `isGenerating = true` -> Hiện hiệu ứng loading xịn sò thay vì đứng im.

Bro xem bản "bóc tách" chi tiết từng đường kim mũi chỉ từ BE đến FE này đã đúng "tần số" của bro chưa? Có check box rõ ràng để giao task luôn. Thấy "bánh cuốn" rồi thì báo mình 1 câu để mình mở file lên gõ code làm thực tế cái task **[ ] Bê nguyên dàn Prompts** đầu tiên luôn!
