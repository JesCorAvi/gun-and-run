extends PlayerState

func enter(_prev, _data := {}) -> void:
	player.velocity.y = player.jump_velocity
	player.animated_sprite.play("jumpNoGun")

func physics_update(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	player.velocity.x = direction * player.speed
	player.velocity.y += player.get_gravity().y * delta
	player.move_and_slide()

	if player.velocity.y >= 0:
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("equip_weapon"):
		finished.emit(WEAPONED)
