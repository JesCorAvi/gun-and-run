class_name Player
extends CharacterBody2D

@export var speed := 200.0
@export var bullets := 500
@export var jump_velocity := -300.0
@export var bulletType : PackedScene

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
 

func shoot():
	var bullet_instance = bulletType.instantiate()

	bullet_instance.global_position = global_position
	if animated_sprite.flip_h: 
		bullet_instance.direction = Vector2.LEFT
	else:
		bullet_instance.direction = Vector2.RIGHT
		
	bullet_instance.global_position += bullet_instance.direction * 30

	get_tree().current_scene.add_child(bullet_instance)
