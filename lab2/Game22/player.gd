extends Area2D

signal hit

@export var speed := 400 # How fast the player will move (pixels/sec).
var screen_size: Vector2 # Size of the game window.


func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()


func _process(delta: float) -> void:
	var velocity := Vector2.ZERO
	if Demo.enabled:
		velocity = _autopilot()
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0


## โหมด demo (ใช้ตอนอัดวิดีโอ): หลบมอนสเตอร์ที่อยู่ใกล้ และดึงกลับเข้ากลางจอ
func _autopilot() -> Vector2:
	var steer := (screen_size / 2 - position) * 0.004
	for mob in get_tree().get_nodes_in_group("mobs"):
		var away: Vector2 = position - mob.position
		var dist := away.length()
		if dist < 220:
			steer += away.normalized() * (220 - dist) / 40
	if steer.length() < 0.3:
		return Vector2.ZERO
	return steer.normalized()


func start(pos: Vector2) -> void:
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _on_body_entered(_body: Node2D) -> void:
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can not change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
