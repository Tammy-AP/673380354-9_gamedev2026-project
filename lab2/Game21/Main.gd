extends Node2D

const BallScene := preload("res://Ball.tscn")


func _ready() -> void:
	# โหมด demo (ใช้ตอนอัดวิดีโอ): สร้างลูกบอลใหม่ทุก ๆ 1.2 วินาที
	if "--demo" in OS.get_cmdline_user_args():
		while true:
			await get_tree().create_timer(1.2).timeout
			var ball := BallScene.instantiate()
			ball.position = Vector2(randf_range(100, 924), 80)
			$Balls.add_child(ball)


func _unhandled_input(event: InputEvent) -> void:
	# คลิกเมาส์เพื่อสร้าง Ball instance ใหม่ ณ ตำแหน่งที่คลิก
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var ball := BallScene.instantiate()
		ball.position = event.position
		$Balls.add_child(ball)
	# กด R เพื่อเริ่มใหม่
	elif event is InputEventKey and event.pressed and event.keycode == KEY_R:
		get_tree().reload_current_scene()
