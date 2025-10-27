extends PlayerState

func enter(_prev, _data := {}) -> void:
	player.animated_sprite.play("jumpNoGun")

func physics_update(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	player.velocity.x = direction * player.speed
	player.velocity.y += player.get_custom_gravity().y * delta
	player.move_and_slide()

	if player.is_on_floor():
		if direction == 0:
			finished.emit(IDLE)
		else:
			finished.emit(RUNNING)
