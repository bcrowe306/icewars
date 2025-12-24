extends State


# Called when the node enters the scene tree for the first time.
func _enter(previous_state: String):
	animated_sprite.play(animation_name)
