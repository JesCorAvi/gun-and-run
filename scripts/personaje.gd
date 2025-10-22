extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -300.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#gets the imput direction -1, 0 or 1
	var direction := Input.get_axis("move_left", "move_right")
	
	#flips the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	#play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("defaultNoGun")
		else:
			animated_sprite.play("runNoGun")
	else:
		animated_sprite.play("jumpNoGun")
	#applies the movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	if Input.is_action_just_pressed("fire"): 
		shoot()

			
func shoot():
	# Crea una instancia de la escena de la espada
	var bullet = 0
	
	# Define la posición de inicio (justo al lado del personaje)
	bullet.global_position = global_position
	
	
	#Define la dirección
	if animated_sprite.flip_h: 
		bullet.direction = Vector2.LEFT
	else:
		bullet.direction = Vector2.RIGHT
		
	#Ajusta la posición para que no aparezca en el centro
	bullet.global_position += bullet.direction * 20
	bullet.global_position.y += -10
	#Añade la espada al árbol de escenas.
	get_tree().root.add_child(bullet)

	
	
