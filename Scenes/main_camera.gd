extends Camera2D


var shake_strength: float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


@export_range(0, 15.0, 1.0) var camera_shake: float = 2.0
@export_range(0, 10, 1) var shake_fade: float = 7.0

func apply_shake(multiplier: int = 1):
	shake_strength = camera_shake + (2 * multiplier)
	
func generateRandomOffset() -> Vector2:
	return Vector2(randf_range(-shake_strength, shake_strength), randf_range(-shake_strength, shake_strength)) + offset

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shake_fade * delta)
		offset = generateRandomOffset()
