extends CPUParticles2D
@onready var player_controller: PlayerController = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_controller.facing_direction:
		direction.x = -1
		position.x = -abs(position.x)
	else:
		direction.x = 1
		position.x = abs(position.x)
