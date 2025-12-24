extends AnimatedSprite2D


func playAnimation():
	visible = true
	play("default")
	


func _on_animation_finished() -> void:
	visible = false # Replace with function body.
