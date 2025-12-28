extends State


func _enter(_previous_state: String):
	animated_sprite.play(animation_name)

func _update(_delta: float):
	pass
	
func _exit(_next_state: String):
	pass	
	
func state_guard(_next_state: String):
	return animated_sprite.animation == animation_name and animated_sprite.frame == 15
