@tool
extends StaticBody2D

## ขนาดของกำแพง (พิกเซล) ปรับได้ในแต่ละ instance
@export var size: Vector2 = Vector2(64, 64):
	set(value):
		size = value
		_update()


func _ready() -> void:
	_update()


func _update() -> void:
	if not is_node_ready():
		return
	var shape := $CollisionShape2D.shape as RectangleShape2D
	shape.size = size
	$TextureRect.size = size
	$TextureRect.position = -size / 2
