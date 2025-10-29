extends Area2D

@export var SPEED : int
signal bullet_destroyed 
var direction = Vector2.RIGHT 
@onready var timer: Timer = $Timer

func _physics_process(delta):
	position += direction * SPEED * delta
	rotation = direction.angle()

func _on_body_entered(body: Node2D):
	if body.has_method("killable"):
		body.killable() 
	queue_free()
	bullet_destroyed.emit()
func _on_timer_timeout() -> void:
	queue_free()
	bullet_destroyed.emit()
