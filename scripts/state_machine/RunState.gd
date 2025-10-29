extends PlayerState

func enter(_prev, _data := {}) -> void:
	player.animated_sprite.play("runNoGun")

func physics_update(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")

	if direction != 0:
		player.velocity.x = direction * player.speed
		player.animated_sprite.flip_h = direction < 0
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.speed)

	player.velocity.y += player.get_gravity().y * delta
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
	elif direction == 0:
		finished.emit(IDLE)
	elif Input.is_action_just_pressed("equip_weapon"):
		finished.emit(WEAPONED)
