extends PlayerState

var is_shooting := false
var can_shoot := true

func enter(_prev, _data := {}) -> void:
	player.animated_sprite.play("default")
	is_shooting = false

	# Conexión segura
	if player.animated_sprite.animation_finished.is_connected(_on_animation_finished):
		player.animated_sprite.animation_finished.disconnect(_on_animation_finished)
	player.animated_sprite.animation_finished.connect(_on_animation_finished)

func physics_update(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")

	# Movimiento normal (aunque esté disparando)
	if direction != 0:
		player.velocity.x = direction * player.speed
		player.animated_sprite.flip_h = direction < 0
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.speed)

	player.velocity.y += player.get_gravity().y * delta
	player.move_and_slide()

	# Disparo
	if Input.is_action_just_pressed("shoot") and not is_shooting and can_shoot:
		is_shooting = true
		player.animated_sprite.play("shoot")
		player.shoot()
		player.bullets -= 1
		if player.bullets == 0:
			can_shoot = false

	# Saltar
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		player.velocity.y = player.jump_velocity
		is_shooting = false 
		player.animated_sprite.play("jump")


	# Quitar arma
	if Input.is_action_just_pressed("equip_weapon"):
		finished.emit(IDLE)

	# Animaciones base (solo si no está disparando)
	if not is_shooting:
		if not player.is_on_floor():
			player.animated_sprite.play("jump")
		elif direction == 0:
			player.animated_sprite.play("default")
		else:
			player.animated_sprite.play("run")

func _on_animation_finished():
	print("Animación terminada: ", player.animated_sprite.animation)
	if player.animated_sprite.animation == "shoot":
		is_shooting = false
		var direction := Input.get_axis("move_left", "move_right")
		if not player.is_on_floor():
			player.animated_sprite.play("jump")
		elif direction == 0:
			player.animated_sprite.play("default")
		else:
			player.animated_sprite.play("run")
