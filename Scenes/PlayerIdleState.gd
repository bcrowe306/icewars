extends State




func _enter(previous_state: String):
	animated_sprite.speed_scale = 1
	animated_sprite.offset = Vector2(0,0)
	animated_sprite.play(animation_name)
