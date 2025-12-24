extends State


func _enter(previous_state: String):
	animated_sprite.play(animation_name)


func _physics_update(delta: float) -> void:
	pass
