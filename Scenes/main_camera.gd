extends Camera2D


var shake_strength: float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


const MAX_SHAKE_STRENGTH: float = 25
@export_range(0, 10, 1) var shake_fade: float = 7.0

func apply_shake(weight: float):
	shake_strength = MAX_SHAKE_STRENGTH * weight
	
func generateRandomOffset() -> Vector2:
	return Vector2(randf_range(-shake_strength, shake_strength), randf_range(-shake_strength, shake_strength))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shake_fade * delta)
		offset = generateRandomOffset()


func _on_character_body_2d_camera_shake(amount: float) -> void:
	apply_shake(amount) # Replace with function body.
