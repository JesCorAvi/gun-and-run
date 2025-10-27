extends Node2D

@onready var label: Label = $Label


func _process(_delta):
	var player = get_tree().get_root().get_node("Nivel/personaje")
	if player:
		label.text = str(player.bullets)
