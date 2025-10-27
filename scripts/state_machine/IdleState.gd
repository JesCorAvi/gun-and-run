extends PlayerState

func enter(_prev, _data := {}) -> void:
	player.velocity.x = 0
	player.animated_sprite.play("defaultNoGun")

func physics_update(delta: float) -> void:
	player.velocity.y += player.get_custom_gravity().y * delta
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
	elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		finished.emit(RUNNING)
	elif Input.is_action_just_pressed("equip_weapon"):
		finished.emit("WeaponEquippedState")
