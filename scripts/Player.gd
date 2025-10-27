class_name Player
extends CharacterBody2D

@export var speed := 200.0
@export var bullets := 500
@export var jump_velocity := -300.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func get_custom_gravity() -> Vector2:
	return ProjectSettings.get_setting("physics/2d/default_gravity_vector") * \
		   ProjectSettings.get_setting("physics/2d/default_gravity")

func shoot():
	print("¡Disparo!")
	# Aquí agregarías la lógica para crear la bala
