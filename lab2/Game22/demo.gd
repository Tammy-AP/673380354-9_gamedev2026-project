## เปิดโหมด demo ด้วยการรัน Godot พร้อม `-- --demo` (ใช้ตอนอัดวิดีโอเท่านั้น)
class_name Demo

static var enabled: bool:
	get:
		return "--demo" in OS.get_cmdline_user_args()
