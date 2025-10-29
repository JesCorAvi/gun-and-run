class_name PlayerState
extends State

const IDLE = "IdleState"
const RUNNING = "RunState"
const JUMPING = "JumpState"
const FALLING = "FallState"
const WEAPONED = "WeaponEquippedState"

var player: Player

func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "PlayerState debe usarse solo en el nodo Player.")
