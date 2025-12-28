extends AnimatedSprite2D
@onready var player_controller: PlayerController = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_controller.facing_direction:
		flip_h = true
		position.x = abs(position.x)
	else:
		flip_h = false
		position.x = -abs(position.x)



func _on_animation_finished() -> void:
	visible = false
