extends AnimatedSprite2D

func _ready() -> void:
	animation_finished.connect(on_finished) # Replace with function body.


func playAnimation():
	
	visible = true
	flip_h = !flip_h
	play()

func on_finished():
	visible = false


func _on_hit_box_hit_registered(_target: Node) -> void:
	playAnimation() # Replace with function body.
