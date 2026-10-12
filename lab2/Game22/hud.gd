extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game


func _ready() -> void:
	$StudentLabel.text = "ID: %s\n%s" % [Student.ID, Student.NAME]
	if Demo.enabled:
		_demo_loop()


func _demo_loop() -> void:
	while true:
		await get_tree().create_timer(1.5).timeout
		if $StartButton.visible:
			_on_start_button_pressed()


func show_message(text: String) -> void:
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


func show_game_over() -> void:
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	$Message.text = "Space Dodge!\nAvoid the aliens!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()


func update_score(score: int) -> void:
	$ScoreLabel.text = str(score)


func _on_start_button_pressed() -> void:
	$StartButton.hide()
	start_game.emit()


func _on_message_timer_timeout() -> void:
	$Message.hide()
