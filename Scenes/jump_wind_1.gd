extends AnimatedSprite2D
class_name JumpWind

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_finished.connect(self._on_finished) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_finished():
	queue_free()
